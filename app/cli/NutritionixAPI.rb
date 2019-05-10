require 'net/http'
require 'json'
require 'net/https'

class NutritionixAPI

  def self.get_mealinfo(detail)
    @body = {
      "query" => detail,
      "timezone" => "US/Eastern"
    }.to_json

    uri = URI.parse("https://trackapi.nutritionix.com/v2/natural/nutrients")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'x-app-key' => 'c1c9449f86cac6f5c48e9da9eb390dc5', 'x-app-id' =>  '2d7f68ea', 'Content-Type' =>'application/json'})
    req.body = @body
    res = https.request(req)
  #puts "Response #{res.code} #{res.message}: #{res.body}"
    JSON.parse(res.body)["foods"]

  end

  def self.get_exerciseinfo( detail, gender, weight_kg, height_cm, age_years )
    @body = {
      "query" => detail,
      "gender" => gender,
      "weight_kg" => weight_kg,
      "height_cm" => height_cm,
      "age" => age_years
    }.to_json

    uri = URI.parse("https://trackapi.nutritionix.com/v2/natural/exercise")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'x-app-key' => 'c1c9449f86cac6f5c48e9da9eb390dc5', 'x-app-id' =>  '2d7f68ea', 'Content-Type' =>'application/json'})
    req.body = @body
    res = https.request(req)
    JSON.parse(res.body)["exercises"]

  end

  def self.meal( meal, detail )
    # Returns an array of hashes which includes the following
    # For the moment, we are only interested in those marked with **
    # "food_name"**
    # "serving_qty"**
    # "serving_unit"**
    # "serving_weight_grams"** Not using yet, but would be the 1st to use
    # "nf_calories"**
    # "nf_total_fat"=>16.47,
    #   "nf_saturated_fat"=>7.71,
    #   "nf_cholesterol"=>73.79,
    #   "nf_sodium"=>275.18,
    #   "nf_total_carbohydrate"=>65.09,
    #   "nf_dietary_fiber"=>0.82,
    # "nf_sugars"=>47.09,
    # "nf_protein"=>4.23,
    # "nf_potassium"=>82.77,
    # "nf_p"=>68.47,

    myhash = get_mealinfo( detail )
    if myhash # Fixes the crash if no data is returned
      recordscreated=myhash.length
      myhash.each do |hash, food |
        detail = "#{hash["serving_qty"]} #{hash["serving_unit"]} of #{hash["food_name"]}"
        calories=hash["nf_calories"]
        MealDetail.create( meal_id:meal.id, detail:detail,  calories:calories)
      end
    else
      recordscreated=0
    end

    recordscreated

  end

  def self.exercise( exercise, detail )
    # Returns an array of hashes which includes the following
    # For the moment, we are only interested in those marked with **

    gender = exercise.user.gender[0]
    weight_kg = exercise.user.latest_weight_kg
    height_cm = exercise.user.height_cm
    age_years = exercise.user.age_years
    myhash = get_exerciseinfo( detail, gender, weight_kg, height_cm, age_years )
    recordscreated=myhash.length
    myhash.each do |hash |
      detail = "#{hash["name"]} for #{hash["duration_min"]} minutes"
      calories=hash["nf_calories"]
      ExerciseDetail.create( exercise_id:exercise.id, detail:detail,  calories:calories)
    end
    recordscreated
  end

end

# mhash.map {|m| m["serving_qty"].to_s + " " + m["serving_unit"] + " of  " + m["food_name"]  }
# mhash.map {|m| m["serving_qty"]} --- string
# mhash.map {|m| m["serving_unit"]} ---
# mhash.map {|m| m["serving_weight_grams"]}
# mhash.map {|m| m["nf_calories"]}
