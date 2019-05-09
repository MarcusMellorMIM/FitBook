# require 'terminal-table'
class DailyCLI

    def self.welcome
    # Display some fancy stuff,
       pastel = Pastel.new
       font = TTY::Font.new
       puts pastel.blue(font.write("Daily"))
    end
    #show date
    def self.day_selection
     diarydate = MenuCLI.getdatetime("Please enter day details")
     puts "Your details for #{diarydate} is as follows:"
    end

def self.tableone(user)
      rows = []
rows << ['Name', user.name]
rows << ['Date of birth', "#{user.dob.day}-#{user.dob.month}-#{user.dob.year}"]
rows << ['Height_cm', user.height_cm]
rows << ['Gender', user.gender]

table = Terminal::Table.new :rows => rows,:title => "Personal details",:style => {:width => 50}
puts table
# > puts table
end
   def self.exercises(user)
      Exercise.all.select{|exercise|exercise.meal_details == user.self}
   end

    def self.display_details(user)
     user = User.latest_weight_kg
    end

    def self.run
      welcome
      day_selection
      current_day(user)
      person_detail(user)
    end
end
