class View
  def self.show_events(events)
    events.each_with_index {|v,i| puts "-------------------------------\nEvent #{i+1}\n---#{v.title}\n---#{v.venue}\n---#{v.date.strftime("%A, %d %B, %Y")}\n---#{v.time.strftime("%H:%M")}"  }
  end

end