require_relative("calendar")
require_relative("validations")
class Driver 
  include Validations
  def initialize
    @calendar = Calendar.new
  end
  def run
    puts "Welcome ! Today is #{Time.new.day}/#{Time.new.month}/#{Time.new.year} "
    self.show_main_menu
    flag = 0
    while flag != 8
      flag = Validations.input_integer
      if(!flag.between?(1,8))
        puts "Invalid Choice ! "
      elsif flag == 1
        self.month_view
      elsif flag == 2
        self.add_event
      end


    end
  end

  def add_event
    puts "Please enter the title: "
    title = gets
    puts "Please enter the venue: "
    venue = gets 
    puts "Please enter the date(dd/mm/yyyy): "
    date = Validations.input_date
    puts "Please enter the time(HH:MM): "
    time = Validations.input_time
    @calendar.add_event(date, time, title, venue)
  end

  def month_view

    @calendar.month_view

  end


  def show_main_menu
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