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
    puts pastel.blue(font.write("Create a person"))
  end

  def self.userdetails
    user = nil
    prompt = TTY::Prompt.new
    name = prompt.ask("Please enter your name", default: ENV['USER'] )
    dob = prompt.ask("Please enter your dob YYYYMMDD")
    height_cm = prompt.ask("Please enter your height in cm")
    gender = prompt.select("Please enter your gender ", %w(Male Female))
    weight_kg = prompt.ask("Please enter your weight in kg")

    puts "Please confirm the following is correct ... "
    puts "Your name is #{name}, you are #{gender} and you were born on #{dob}"
    puts "You are #{height_cm} cm tall, and weigh #{weight_kg} kilos"
    confirm = prompt.yes?( 'Is this correct ? ' )

    if confirm
      user = User.create( name:name, dob:dob, height_cm:height_cm, gender:gender )
      weight = Weight.create( weight_kg:weight_kg, user_id:user.id)
    end

    user

  end

  def self.run
      welcome
      userdetails
  end

end
