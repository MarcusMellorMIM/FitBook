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
rows << :separator
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
    def self.getcalories(rows, user, date)
      bmr = user.bmr(date)
      exercise = user.exercisediarycalories(date)
      meal_calories = user.mealdiarycalories(date)
      deficit = meal_calories - bmr - exercise
      # calories_array = [];
      # exercise_array =[];
      # deficit_array =[];
      # meal_array =[];

      calories_array =  "Your BMR(rate at which your body uses energy when resting) is:"
      exercise_array = "The total calories you burnt from exercising:"
      meal_array = "The total calories of your meal is:"
      deficit_array = "Your deficit is:"

      rows << :separator
      rows << [calories_array, "#{bmr}"]
      rows << [exercise_array, "#{exercise} calories"]
      rows << [meal_array, "#{meal_calories}"]
      rows << [deficit_array, "#{deficit}"]
      # # rows << [exercise_array]
      # rows << [deficit_array]
# deficit = food - bmr - exercise
rows
    end
    def self.run(user)

      prompt = TTY::Prompt.new
      welcome
      date = day_selection
      rows = []
      rows = tableone(rows,user)
      rows = getexercise(rows,user,date)
      rows = getmeal(rows,user,date)
      rows = getcalories(rows, user, date)
       table = Terminal::Table.new :rows => rows,:title => "Details for #{user.name}"
       puts table
       prompt.yes?('Hit return to continue')

    end
end
