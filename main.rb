require_relative("calendar")
require_relative("validations")
class Driver 
  include Validations
  def initialize
    @calendar = Calendar.new
  end
  def run
    puts "Welcome ! Today is #{Time.new.day}/#{Time.new.month}/#{Time.new.year} "
    self.MainMenu
    flag = 0
    while flag != 8
      flag = Validations.InputInteger
      if(!flag.between?(1,8))
        puts "Invalid Choice ! "
      elsif flag == 1
        self.MonthView
      elsif flag == 2
        self.AddEvent
      end


    end



  end

  def AddEvent
    puts "Please enter the title: "
    title = gets
    puts "Please enter the venue: "
    venue = gets 
    puts "Please enter the date(dd/mm/yyyy): "
    date = Validations.InputDate
    puts "Please enter the time(HH:MM): "
    time = Validations.InputTime
    @calendar.AddEvent(date, time, title, venue)
  end

  def MonthView

    @calendar.ShowMonthView

  end


  def MainMenu
    puts "1-- View the whole month\n"
    puts "2-- Add Event\n"
    puts "3-- Remove Event\n"
    puts "4-- Update Event\n"
    puts "5-- Show events of a specific month\n"
    puts "6-- Show events of a specific day\n"
    puts "7-- Load From A File\n"
    puts "8-- Exit App\n"
  end


end 


dr = Driver.new

dr.run