require "pry"
require_relative "../config/environment.rb"

puts "Marcus test run file "

#resulthash = NutritionixAPI.get_info("one slice of lemon cake, with one scoop of vanila icecream")
info("one slice of lemon cake, with one scoop of vanila icecream")

mhhash=NutritionixAPI.get_exerciseinfo("ran a marathon", "M",103,177,51)


  # "food_name"
  # "serving_qty"
  # "serving_unit"
  # "serving_weight_grams"
  # "nf_calories"
  #
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
  #
binding.pry

puts "Done "
