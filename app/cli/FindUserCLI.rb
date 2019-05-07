# Marcus 7/5/19
# Will prompt the user for a name, and return one or more
# If 1, it will askl the user to confirm ... and return that user object
# If more than 1, it will ask the user to select, then confirm and then return with that user object.
class FindUserCLI

  def self.welcome
  # Display some fancy stuff, as a welcome
   pastel = Pastel.new
   font = TTY::Font.new
   puts pastel.blue(font.write("Find a person"))
  end

  def self.finduser

    choice = false
    prompt = TTY::Prompt.new

    while !choice
      user = nil
      name = prompt.ask("Who would you like to find ?" )
      user = User.find_by_name(name)
      if user
        choice = prompt.yes?("You have found #{user.name} last updated on #{user.updated_at}, is this correct ?")
      else
        choice = !prompt.yes?("Sorry, but no people were found with this name, #{name}, do you want to try again?")
      end
    end
    user
  end


  def self.run
    # The main method that is run from external methods
    choice = true
    welcome
    prompt = TTY::Prompt.new
    user = finduser

  end

end
