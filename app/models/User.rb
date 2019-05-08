class User < ActiveRecord::Base
  has_many :weights
  has_many :exercises
  has_many :exercise_details, through: :exercises
  has_many :exercise_types, through: :exercises
  has_many :meals
  has_many :meal_details, through: :meals
  has_many :meal_types, through: :meals

  def age_years( date_entered=Date.today.year )
    # Calculate the age in years from today as default, or a date passed in
    if self.dob
      date_entered - self.dob.year
    end
  end

  def latest_weight_kg
    # Get the last weight entered, with the assumption that this will be the latest.
    self.weights.last.weight_kg
  end

  def bmr
    # Calculate the Basal Metabolic Rate using a persons height, weight, gender and age
    bmr=nil

    age = age_years
    weight_kg = latest_weight_kg
    height_cm = self.height_cm

    if age && weight_kg && height_cm
      if self.gender[0]=='M'
  # Using the Harris-Benedict BMR equation from
  # https://www.thecalculatorsite.com/articles/health/bmr-formula.php
          bmr= 66.47 + (13.75 * weight_kg) +(5.003 *height_cm) - (6.755 *age)
      else
          bmr=655.1 + (9.563 * weight_kg)+(1.85 * height_cm)-(4.676 * age)
      end
    end
    bmr.round(2)
  end

end
