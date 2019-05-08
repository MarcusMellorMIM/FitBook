class MealCLI

  def self.welcome
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    font = TTY::Font.new
    puts pastel.blue(font.write("Record a meal"))
    puts ''
  end

  def self.getdate
    prompt = TTY::Prompt.new

    year = Date.current.year
    month = Date.current.month
    day = Date.current.day
    hour = DateTime.current.hour


# Prompt the user to confirm the year, defaulting to this one
# Prompt the user to confirm the month, defaulting to this one
# Same for day and hour.

    timeofmeal = prompt.select('When did you have your meal', %w(Now Today Yesterday Other))

    if timeofmeal != 'Now'
      selecthour = prompt.ask('Please enter hour', default: hour)
      hour = selecthour.to_i
    end


    if timeofmeal =='Yesterday'
      day = Date.yesterday.day
    end
    if timeofmeal =='Other'
      day = prompt.ask("Please enter day", default: day).to_i
      month = prompt.ask("Please enter month", default: month).to_i
      year = prompt.ask("Please enter year", default: year).to_i
    end
 mydate = DateTime.new(year,month,day, hour)
end


  def self.mealtypes
     MealType.all.map{|m|m.detail}
  end

  def self.addmeal(user)
    prompt = TTY::Prompt.new
    meal_details = prompt.ask("Please enter your meal details")

    mealdate = getdate

    mealtypeselect =  prompt.select("Please rate your meal details",mealtypes)


mealtypeselectid = MealType.find_by(detail:mealtypeselect).id
    carl =  prompt.ask( "If you know calories add them, or hit return and we\'ll calculate them for you")
      if carl.to_i > 0
      puts "You had one #{mealtypeselect} meal, which consisted of #{meal_details}, which is #{carl} calories."
     else
      puts "You had one #{mealtypeselect} meal, which consisted of #{meal_details}, which is calories.."
     end
      confirm = prompt.yes?( 'Is this correct ?' )
      if confirm
        meal1 = Meal.create(detail:meal_details, user_id:user.id, meal_type_id:mealtypeselectid)
        meal2 = MealDetail.create(calories:carl, meal_id:meal1.id, detail:meal1.detail)
        # if calories are set create a mealdetail, if not call the api
        end
    end



    def self.run(user)
      welcome
      addmeal(user)
    end
end
