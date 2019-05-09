class WeightCLI

  def initialize
    @prompt = TTY::Prompt.new
    @pastel = Pastel.new
    @font = TTY::Font.new
    @user = nil
  end


  def self.welcome
    prompt = TTY::Prompt.new
    pastel = Pastel.new
    font = TTY::Font.new
    puts pastel.blue(font.write("Weight"))
    puts ''
  end

  def self.enterweight( user )
    prompt = TTY::Prompt.new
    weight_kg = prompt.ask("Please enter your weight")
    puts "Please confirm the following is correct. Your weight is recorded as #{weight_kg} Kg."
    confirm = prompt.yes?( 'Is this correct ?' )

    if confirm
      weight = Weight.create(weight_kg:weight_kg, user_id:user.id)
    end

    weight

  end

  def self.run( user )
    welcome
    enterweight( user )
  end

end
