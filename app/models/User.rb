class User < ActiveRecord::Base
  has_many :weights
  has_many :exercises
  has_many :exercise_details, through: :exercises
  has_many :exercise_types, through: :exercises
  has_many :meals
  has_many :meal_details, through: :meals
  has_many :meal_types, through: :meals
end
