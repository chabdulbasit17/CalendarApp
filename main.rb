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

  def MainMenu
    puts "1-- View the whole month\n"
    puts "2-- Add Event\n"
    puts "3-- Remove Event\n"
    puts "4-- Update Event\n"
    puts "5-- Show events of a specific month\n"
    puts "6-- Show events of a specific day\n"
    puts "7-- Load From A File\n"
  end


end 


dr = Driver.new

dr.run