class ExerciseCLI
# AM Is called from MenuCLI and handles the Meal CLI interactions
  def self.welcome
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    font = TTY::Font.new
    puts pastel.blue(font.write("Exercise"))
    puts ''
  end

  def self.exercisetypes
     ExerciseType.all.map{|m|m.detail}
  end

  def self.addexercise(user)
    prompt = TTY::Prompt.new
    details = prompt.ask("Please enter your exercise details")
    date = MenuCLI.getdatetime("When did you have your exercise?")
puts date
    typeselect =  prompt.select("Please rate your exercise",exercisetypes)
    typeselectid = ExerciseType.find_by(detail:typeselect).id
    calories =  prompt.ask( "If you know calories add them, or hit return and we\'ll calculate them for you")
    if calories.to_i > 0
      puts "You entered; #{details}."
      puts "It was #{typeselect} expending #{calories} calories"
      confirm = prompt.yes?( 'Is this correct ?' )
      if confirm
        e1 = Exercise.create(detail:details, user_id:user.id, exercise_type_id:typeselectid,exercise_date:date)
        ExerciseDetail.create(detail:details, exercise_id:e1.id, calories:calories)
      end
    else
      puts "You entered; #{details}."
      puts "It was #{typeselect}. The calories will be calculated"
      confirm = prompt.yes?( 'Is this correct ?' )
      if confirm
        e1 = Exercise.create(detail:details, user_id:user.id, exercise_type_id:typeselectid,meal_date:date)
        excount = NutritionixAPI.exercise(e1, details)
        e1.exercise_details.map {|m| puts "#{m.detail} consisting of #{m.calories} calories "} #display in a table
        # Display what has been created
          # if calories are set create a mealdetail, if not call the api
      end
    end
  end

  def self.run(user)
    welcome
    addexercise(user)
  end

end
