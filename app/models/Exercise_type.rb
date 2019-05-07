class ExerciseType < ActiveRecord::Base
  has_many :exercises
  has_many :users, through: :excercises
end
