class MealCLI
# AM Is called from MenuCLI and handles the Meal CLI interactions
  def self.welcome
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    font = TTY::Font.new
    puts pastel.blue(font.write("Meal"))
    puts ''
  end

  def self.mealtypes
     MealType.all.map{|m|m.detail}
  end

  def self.addmeal(user)
    prompt = TTY::Prompt.new
    meal_details = prompt.ask("Please enter your meal details")
    mealdate = MenuCLI.getdatetime("When did you have your meal?")
    mealtypeselect =  prompt.select("Please rate your meal details",mealtypes)
    mealtypeselectid = MealType.find_by(detail:mealtypeselect).id
    carl =  prompt.ask( "If you know calories add them, or hit return and we\'ll calculate them for you")
    if carl.to_i > 0
      puts "You had one #{mealtypeselect} meal, which consisted of #{meal_details}, which is #{carl} calories."
      confirm = prompt.yes?( 'Is this correct ?' )
      if confirm
        meal1 = Meal.create(detail:meal_details, user_id:user.id, meal_type_id:mealtypeselectid,meal_date:mealdate)
      end
    else
      puts "You entered; #{meal_details}."
      puts "It was #{mealtypeselect}. The calories will be calculated"
      confirm = prompt.yes?( 'Is this correct ?' )
      if confirm
        meal1 = Meal.create(detail:meal_details, user_id:user.id, meal_type_id:mealtypeselectid,meal_date:mealdate)
        mealcount = NutritionixAPI.meal(meal1, meal_details)
        meal1.meal_details.map {|m| puts "#{m.detail} consisting of #{m.calories} calories "} #display in a table
        # Display what has been created
          # if calories are set create a mealdetail, if not call the api
      end
    end
  end

  def self.run(user)
    welcome
    addmeal(user)
  end

end
