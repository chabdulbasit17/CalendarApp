class Event
  attr_accessor :date , :time , :venue , :title 

  def initialize(date, time, venue, title)
    @date = date 
    @time = time
    @venue = venue
    @title = title
  end

end 