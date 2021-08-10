require_relative("validations")
require_relative("event")
require("date")

class Calendar
  include Validations
  def initialize
    @events = Hash.new { |h, k| h[k] = [] }
  end 

  def add_event(date, time, venue, title)
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
    
    return true
  end 

  def month_view(month=0)
    month == 0? curr=Time.new.month : curr = month

    puts "Events for the month #{Date::MONTHNAMES[curr]}"
    if @events[curr].empty?
      puts "No events for this month."
      return 0
    end
    @events[curr].each_with_index {|v,i| puts "-------------------------------\nEvent #{i+1}\n---#{v.title}\n---#{v.venue}\n---#{v.date.strftime("%A, %d %B, %Y")}\n---#{v.time.strftime("%H:%M")}"  }
    
  end

  def delete_event(month, index)
    if index > @events[month].size || index < 1
      return nil
    end
    @events[month].delete_at(index-1) rescue nill
    return true
  end

  def update_event(month,index, *event) #title, venue, date, time
    title, venue, date, time = event
    if index > @events[month].size || index < 1
      return nil
    end
    if(add_event(date, time, venue, title))
      delete_event(month, index)
      return true
    end
    return false

  end

end