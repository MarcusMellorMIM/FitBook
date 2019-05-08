require 'net/http'
require 'json'
require 'net/https'

class NutritionixAPI

  def self.get_info(params)
  @body = {
    "query" => params,
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

  def self.meal( detail )
    # Returns an array of hashes which includes the following
    # For the moment, we are only interested in those marked with **
    # "food_name"**
    # "serving_qty"**
    # "serving_unit"**
    # "serving_weight_grams"**
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

    returnarray=[]
    myhash = get_info( detail )
    myhash.each do |hash, food |
      returnarray << hash["food_name"]
    end
    returnarray
  end

end
