class User < ActiveRecord::Base
  has_many :weights
  has_many :exercises
  has_many :exercise_details, through: :exercises
  has_many :exercise_types, through: :exercises
  has_many :meals
  has_many :meal_details, through: :meals
  has_many :meal_types, through: :meals

  def bmr
    # Calculate the Basal Metabolic Rate using a persons height, weight, gender and age
    bmr=nil

    if self.dob
      age = self.dob.year - Date.today.year
    end
    weight_kg = self.weights.last.weight_kg
    height_cm = self.height_cm

    if age && weight_kg && height_cm
    if self.gender[0]=='M'
          bmr= 88.362 + (13.397 * weight_kg) +(4.799 *height_cm) - (5.677 *age)
    else
          bmr=447.593 + (9.247 * weight_kg)+(3.098 * height_cm)-(4.330 * age)
    end
  end

    bmr
  end
end
