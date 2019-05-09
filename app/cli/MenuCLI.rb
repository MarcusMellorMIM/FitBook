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
    mydate = DateTime.new(year,month,day)
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
    end

    if timeof =='Other'
      day = prompt.ask("Please enter day", default: day).to_i
      month = prompt.ask("Please enter month", default: month).to_i
      year = prompt.ask("Please enter year", default: year).to_i
    end
    mydate = Date.new(year,month,day, hour)
  end

 def self.welcome
   pastel = Pastel.new
   font = TTY::Font.new
   puts pastel.blue(font.write("Fitbook"))
   puts 'Welcome!'
 end

 def self.usermenu
    prompt = TTY::Prompt.new
    choices =['Create a new person', 'Find a person', 'Quit']
    choice = prompt.select("Please choose an option ",choices)
    puts choice
  if choice == 'Create a new person'
    @@user = CreateUserCLI.run
  elsif choice == 'Find a person'
    @@user = FindUserCLI.run
  end
  @@user
 end

 def self.fullmenu
    prompt = TTY::Prompt.new
    choices =["Create a new person", "Find a person", "Record a new weight", "Record a meal","Record exercise activity","View your daily diary","View summary details", "Quit"]
    choice = prompt.select("Please choose an option for #{@@user.name}",choices)

    if choice == 'Create a new person'
      @@user = CreateUserCLI.run
    elsif choice == 'Find a person'
      @@user = FindUserCLI.run
    elsif choice == "Record a new weight"
      WeightCLI.run( @@user )
    elsif choice == "Record a meal"
      MealCLI.run( @@user )
    end

  end

  def self.run
    prompt = TTY::Prompt.new
    continue = true
    user = nil
    welcome
    while (continue)
      if !@@user
        @@user = usermenu
      end

      if @@user
        fullmenu
      end
      continue = prompt.yes?( 'Do you wish to continue?')
    end
  end

end
