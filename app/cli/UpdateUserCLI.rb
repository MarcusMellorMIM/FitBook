class UpdateUserCLI

  def self.welcome
 # Display some fancy stuff,
   pastel = Pastel.new
   font = TTY::Font.new
   puts pastel.blue(font.write("Update"))
 end


  def self.run( user )
    # The main method that is run from external methods
    welcome
    prompt = TTY::Prompt.new
    name=user.name
    dob=user.dob
    height_cm=user.height_cm
    gender=user.gender
    puts "Just type in the correct details to change "
    name = prompt.ask("Name: ", default:name )
    if prompt.yes?("Change the date of birth from #{dob}")
      dob=MenuCLI.getdate("Please enter the date of birth")
    end
    height_cm = prompt.ask("Height in cm", default:height_cm)
  #  gender = prompt.select("Please enter the gender ", %w(Male Female))
    if prompt.yes?("Change gender from #{gender}")
      gender = prompt.select("Please enter the gender ", %w(Male Female))
    end

    if prompt.yes?( 'Confirm changes ? ' )
        user.name=name
        user.height_cm=height_cm
        user.gender=gender
        user.dob=dob
        user.save
    end

  end
end
