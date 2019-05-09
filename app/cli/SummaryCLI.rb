class SummaryCLI

  def self.welcome
# Display some fancy stuff,
   pastel = Pastel.new
   font = TTY::Font.new
   puts pastel.blue(font.write("Summary"))
  end

#show date
  def self.getdate
    date = MenuCLI.getdate("What date do you want to summarise to ?")
    puts "Your details for #{date} is as follows:"
    date
  end

  def self.getdates( date, qty)
    row=["Dates"]
    qty.times do
      row << "#{date.day}-#{date.month}-#{date.year}"
      date=date+1
    end
    row
  end

  def self.getbmr(user, date, qty)
    row = user.bmrsummary(date,qty)
    row.unshift("BMR-")
    row
  end

  def self.getweight(user, date, qty)
    row = user.weightsummary(date,qty)
    row.unshift("Weight")
    row
  end

  def self.getmeal(rows, user, date, qty)
    row_hash = user.mealsummary(date,qty)
    row_type = row_hash.map {|h| h[:type]? h[:type].detail : "" }
    row_type.unshift("Food")
    row_calories = row_hash.map {|h| h[:calories] }
    row_calories.unshift("Calories+")
    rows << row_type
    rows << row_calories
    rows
  end

  def self.getexercise(rows, user, date, qty)
    row_hash = user.exercisesummary(date,qty)
    row_type = row_hash.map {|h| h[:type]? h[:type].detail : "" }
    row_type.unshift("Exercise")
    row_calories = row_hash.map {|h| h[:calories] }
    row_calories.unshift("Calories-")
    rows << row_type
    rows << row_calories
    rows
  end

  def self.getdeficit(rows, user, date, qty)
    row_hash = user.caloriesummary(date,qty)
    row_deficit = row_hash.map {|h| h[:deficit].round(2) }
    row_deficit.unshift("Deficit")
    rows << row_deficit
    rows
  end

  def self.run( user )
    prompt = TTY::Prompt.new
    rows=[]
    welcome
    date=getdate
    iterations = prompt.ask('How many days?', default:5).to_i
    rows << getdates(date,iterations)
    rows << :separator
    rows << getbmr(user, date,iterations)
    rows << getweight(user, date,iterations )
    rows << :separator
    rows = getmeal( rows, user, date, iterations )
    rows << :separator
    rows = getexercise( rows, user, date, iterations )
    rows << :separator
    rows = getdeficit( rows, user, date, iterations )
    table = Terminal::Table.new :rows => rows,:title => "Summary for #{user.name}"
    #,:style => {:width => 50}
    puts table
    prompt.yes?('Hit return to continue')
    
   # > puts table
  end

end
