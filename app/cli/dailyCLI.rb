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
     diarydate
    end

def self.tableone(rows, user)

rows << ['Name', user.name]
rows << ['Date of birth', "#{user.dob.day}-#{user.dob.month}-#{user.dob.year}"]
rows << ['Height_cm', user.height_cm]
rows << ['Gender', user.gender]
rows

# > puts table
end


   def self.getexercise(rows, user, date)
      # user.exercisediary
      # myarray = user.exercisediary(date)

      user.exercisediary(date).each do |a|
        detail_array=[]
        detail_array << a.detail
        detail_array << a.exercise_type.detail
        rows << detail_array

        a.exercise_details.each do |md|
           detail2_array = []
           detail2_array << md.detail
           detail2_array << md.calories
           rows << detail2_array
         end
      end
      rows

   end

   def self.getmeal(rows, user, date)
      # user.exercisediary
      # myarray = user.exercisediary(date)

      user.mealdiary(date).each do |a|
        detail_array=[]
        detail_array << a.detail
        detail_array << a.meal_type.detail
        rows << detail_array

        a.meal_details.each do |md|
           detail2_array = []
           detail2_array << md.detail
           detail2_array << md.calories
           rows << detail2_array
         end
      end
      rows

   end

    def self.display_details(user)
     user = User.latest_weight_kg
    end

    def self.run(user)
      welcome
      date = day_selection
      rows = []
      rows = tableone(rows,user)
      rows = getexercise(rows,user,date)
      rows = getmeal(rows,user,date)
       table = Terminal::Table.new :rows => rows,:title => "Personal details"
       puts table

    end
end
