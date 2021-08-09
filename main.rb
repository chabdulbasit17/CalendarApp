require_relative("calendar")
require_relative("validations")
require("date")
class Driver 
  include Validations
  def initialize
    @calendar = Calendar.new
  end
  def run
    flag = 0
    while flag != 8
      self.show_main_menu
      flag = Validations.input_integer
      if(!flag.between?(1,8))
        puts "Invalid Choice ! "
      elsif flag == 1
        self.month_view
      elsif flag == 2
        self.add_event
      elsif flag == 3
        self.delete_event
      end
    Validations.press_enter

    end
  end

  def add_event
    puts "Please enter the title: "
    title = gets.chomp
    puts "Please enter the venue: "
    venue = gets.chomp
    puts "Please enter the date(dd/mm/yyyy): "
    date = Validations.input_date
    puts "Please enter the time(HH:MM): "
    time = Validations.input_time
    if @calendar.add_event(date, time, title, venue)
      puts "Successfully added."
    else
      puts "Event was not added."
    end
  end

  def month_view

    @calendar.month_view

  end

  def delete_event
    puts "Please enter the month's full name: (i.e) August"
    mth = gets.chomp.capitalize
    month = Date::MONTHNAMES.index(mth)
    if month.nil?
      puts "Invalid month name."
      return
    end
    if @calendar.month_view(month) == 0
      return
    end
    puts "Please enter the index of event you want to remove"
    index= Validations.input_integer
    if @calendar.delete_event(month,index)
      puts "Successfully Deleted"
    else
      puts "The event was not deleted. Please enter valid index"
    end
  end


  def show_main_menu
    puts "Welcome ! Today is #{Time.new.day}/#{Time.new.month}/#{Time.new.year} "
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