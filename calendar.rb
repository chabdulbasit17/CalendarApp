require_relative("validations")

require("date")

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
    if(date.year < Time.new.year)
      puts "Cannot add event in the past"
      return
    end

    event_to_add = Event.new(date, time, title, venue)
    @events[date.month].push(event_to_add)
    
    return "success"
  end 

  def ShowMonthView(month=0)
    month == 0? curr=Time.new.month : curr = month
    puts "Events for the month #{Date::MONTHNAMES[curr]}"
    if @events[curr].empty?
      puts "No events for this month."
      return
    end
    @events[curr].each {|v| puts v.date.strftime("%A, %d %B, %Y"), v.time.strftime("%H:%M"), v.venue, v.title}
    
  end





end