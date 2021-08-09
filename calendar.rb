require_relative("validations")

class Calendar
  include Validations
  def initialize
    @events = Hash.new { |h, k| h[k] = [] }
  end 

  def AddEvent(date, time, venue, title)
    if date.nil?
      puts "Error in date. Exiting back to main menu..."
      return 
    end 
    if time.nil?
      puts "Error in time. Exiting back to main menu..."
      return
    end 
    event_to_add = Event.new(date, time, title, venue)
    @events[Date.parse(date).month].push(event_to_add)
    p @events
    return "success"
  end 

  


end