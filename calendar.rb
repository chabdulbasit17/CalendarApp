require_relative("validations")

class Calendar
  include Validations
  def initialize
    @events = Hash.new { |h, k| h[k] = [] }
  end 

  def AddEvent
    puts "Please enter the title: "
    title = gets
    puts "Please enter the venue: "
    venue = gets 
    puts "Please enter the date(dd/mm/yyyy): "
    date = Validations.InputDate
    if date.nil?
      puts "Error in date. Exiting back to main menu..."
      return 
    end 
    puts "Please enter the time(HH:MM): "
    time = Validations.InputTime 
    if time.nil?
      puts "Error in time. Exiting back to main menu..."
      return
    end 
    event_to_add = Event.new(date, time, venue, title)
    @events[date.month].push(event_to_add)

    p @events
    return "Event added successfully."


  end 



end