# FitBook Mod 1 - Marcus 7/5/19
#
# It will create a new user User.create , or allow a person to quit
# It needs a name, dob, height, weight if known.
# Once saved, the saved data is shown including the BMR
#
# The CLI should guide the person, in the user creation process
# It should allow for any changes prior to saving.
#
# It will return the newly created user class.

class CreateUserCLI

   def initialize
     @prompt = TTY::Prompt.new
     @pastel = Pastel.new
     @font = TTY::Font.new
     @user = nil
   end

   def self.welcome
 # Display some fancy stuff,
    pastel = Pastel.new
    font = TTY::Font.new
    puts pastel.blue(font.write("New"))
  end

  def self.userdetails
    user = nil
    prompt = TTY::Prompt.new
    name = prompt.ask("Please enter the name", default: ENV['USER'] )
    dob = MenuCLI.getdate("Please enter the date of birth")
    height_cm = prompt.ask("Please enter the height in cm")
    gender = prompt.select("Please enter the gender ", %w(Male Female))
    weight_kg = prompt.ask("Please enter the latest weight in kg")
    weightdate = MenuCLI.getdatetime("When did you last weigh yourself?")

    puts "Please confirm the following is correct ... "
    puts "#{name}, is #{gender}, born on #{dob}, #{height_cm} cm tall, weighing #{weight_kg} kilos"
    confirm = prompt.yes?( 'Is this correct ? ' )

    if confirm
      user = User.create( name:name, dob:dob, height_cm:height_cm, gender:gender )
      weight = Weight.create( weight_kg:weight_kg, user_id:user.id, weight_date:weightdate)
    end

    user

  end

  def self.run
      welcome
      userdetails
  end

end
