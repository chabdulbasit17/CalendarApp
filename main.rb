require_relative("calendar")

class Driver 
  def initialize
    @calendar = Calendar.new
  end
  def run
    @calendar.AddEvent
  end


end 


dr = Driver.new

dr.run