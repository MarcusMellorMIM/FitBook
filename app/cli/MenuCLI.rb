# It welcomes the user. Ask them if they want to create or find a user.
# If they found a user, they will display all the
# menu options: add weight, add meal, add exercise, view summary or view daily details.
# make the last menu interactive, they can check their last weight that was entered.
class MenuCLI

@@user = nil

  def initialize
    @prompt = TTY::Prompt.new
    @pastel = Pastel.new
    @font = TTY::Font.new
    @user = nil
  end

  def self.getdate( prompt_txt )
    # A generic method to allow a user to enter a date with various defauls
    # Prompt the user to confirm the year, defaulting to this one
    # Prompt the user to confirm the month, defaulting to this one
    # Same for day and hour.
    prompt = TTY::Prompt.new
    year = Date.current.year
    month = Date.current.month
    day = Date.current.day
    puts ( prompt_txt )
    day = prompt.ask("Please enter day", default: day).to_i
    month = prompt.ask("Please enter month", default: month).to_i
    year = prompt.ask("Please enter year", default: year).to_i
    mydate = Date.new(year,month,day)
  end

  def self.getdatetime( prompt_txt)
    # A generic method to allow a user to enter a date with various defauls
    # Prompt the user to confirm the year, defaulting to this one
    # Prompt the user to confirm the month, defaulting to this one
    # Same for day and hour.
    prompt = TTY::Prompt.new
    year = Date.current.year
    month = Date.current.month
    day = Date.current.day
    hour = DateTime.current.hour

    timeof = prompt.select(prompt_txt, %w(Now Today Yesterday Other))

    if timeof != 'Now'
     selecthour = prompt.ask('Please enter hour', default: hour)
     hour = selecthour.to_i
    end

    if timeof =='Yesterday'
      day = Date.yesterday.day
      month = Date.yesterday.month
      year = Date.yesterday.year
    end

    if timeof =='Other'
      day = prompt.ask("Please enter day", default: day).to_i
      month = prompt.ask("Please enter month", default: month).to_i
      year = prompt.ask("Please enter year", default: year).to_i
    end
    mydate = DateTime.new(year,month,day, hour)
  end

 def self.welcome
   pastel = Pastel.new
   font = TTY::Font.new
   puts pastel.blue(font.write("Fitbook"))
 end

 def self.usermenu
    prompt = TTY::Prompt.new
    choices =["Create a new person", "Find a person", "Quit"]
    choice = prompt.select("Please choose an option ",choices)

    if choice == 'Create a new person'
      @@user = CreateUserCLI.run
    elsif choice == 'Find a person'
      @@user = FindUserCLI.run
    end

    choice

 end

 def self.fullmenu
    prompt = TTY::Prompt.new
    choices =["Create a new person", "Find a person", "Update a person", "Record a new weight", "Record a meal","Record exercise activity","View your daily diary","View summary details", "Quit"]
    choice = prompt.select("Please choose an option for #{@@user.name}",choices)

    if choice == 'Create a new person'
      @@user = CreateUserCLI.run
    elsif choice == 'Find a person'
      @@user = FindUserCLI.run
    elsif choice == 'Update a person'
      UpdateUserCLI.run( @@user )
    elsif choice == "Record a new weight"
      WeightCLI.run( @@user )
    elsif choice == "Record a meal"
      MealCLI.run( @@user )
    elsif choice == "Record exercise activity"
      ExerciseCLI.run( @@user )
    elsif choice == "View your daily diary"
      DailyCLI.run( @@user )
    elsif choice == "View summary details"
      SummaryCLI.run( @@user )
    end

    choice

  end

  def self.goodbye
    system "clear"
    welcome
    puts "Thanks for using FitBook"
    puts ""
    puts "The app that allows a person to record the food they eat,"
    puts "the exercise they take and from that, understand whether they"
    puts "are on a path to continual growth, waist size that is, stay as they are,"
    puts "or lose a few of those pesky pounts."
    puts ""
    puts "It uses natural language processing, provided by Nutritionix,"
    puts "to break down the meal and exercise into elements,"
    puts "assigning a calory count against each."
    puts ""
    puts "FitBook, understands what your Basel Metabolic Rate is, the"
    puts "calories you burn by just being alive."
    puts "It calculates this from your weight, height and age."
    puts "The calculation is different for men and women."
    puts ""
    puts "Anthea and Marcus developed this for you to enjoy"
    puts "Please feel free to contribute some cash :)"
    puts ""
    puts "Powered by Nutritionix (c)"

  end

  def self.run
    prompt = TTY::Prompt.new
    continue = true
    user = nil
    while (continue)

      system "clear"
      welcome

      if !@@user
        choice = usermenu
      else
        choice = fullmenu
      end

      if choice=="Quit"
        continue=false
      end
    end

    goodbye

  end

end
