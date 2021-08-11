# frozen_string_literal: true

require('date')
require('colorize')
# Class View for outputting on the console
class View
  def self.show_events(events)
    events.each_with_index do |v, i|
      puts '-' * 10
      puts "Event Number #{i + 1}"
      puts "Title:---#{v.title}"
      puts "Venue:---#{v.venue}"
      puts "Date:---#{v.date.strftime('%A, %d %B, %Y')}"
      puts "Time:---#{v.time.strftime('%H:%M')}"
    end
  end

  def self.grid_view(start_of_month_weekday, event_entries)
    days = %w[M T W T F S S]
    days.each { |d| print format('%-9.3s', "#{d} ") }
    puts
    i = 0
    day_of_month = start_of_month_weekday
    day = 1
    counter = 7
    while i < 30 + start_of_month_weekday
      puts if (counter % 7).zero?
      if i < day_of_month - 1
        print ' '.ljust(9)
        counter += 1
      else
        print  "#{day}(#{event_entries[day]})".ljust(9).red if event_entries[day].positive?
        print  day.to_s.ljust(9).green if event_entries[day].zero?
        counter += 1
        day += 1
      end
      i += 1
    end
    puts
  end
end
