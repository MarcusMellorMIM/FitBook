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

 def self.welcome
   pastel = Pastel.new
   font = TTY::Font.new
   puts pastel.blue(font.write("Fitbook"))
   puts 'Welcome!'
 end

 def self.usermenu
    prompt = TTY::Prompt.new
    choices =['Create a new user', 'Find a new user']
    choice = prompt.select("Please choose an option ",choices)
    puts choice
  if choice == 'Create a new user'
    @@user = CreateUserCLI.run
  else
    @@user = FindUserCLI.run
  end
  @@user
 end

  def self.fullmenu
    prompt = TTY::Prompt.new
    choices =["Record a new weight", "Record a meal","Record exercise activity","View your daily diary","View summary details"]
    choice = prompt.select("Please choose an option ",choices)

    if choice == "Record a new weight"
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
