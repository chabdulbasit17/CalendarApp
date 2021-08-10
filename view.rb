# frozen_string_literal: true

require('date')
require('colorize')
class View
  def self.show_events(events)
    events.each_with_index do |v, i|
      puts "-------------------------------\nEvent #{i + 1}\n---#{v.title}\n---#{v.venue}\n---#{v.date.strftime('%A, %d %B, %Y')}\n---#{v.time.strftime('%H:%M')}"
    end
  end

  def self.grid_view(start_of_month_weekday, event_entries)
    p event_entries[26]
    days = %w[M T W T F S S]
    days.each { |d| print format('%-8.3s', "#{d} ") }
    puts
    i = 0
    day_of_month = start_of_month_weekday
    day = 1
    counter = 7
    while i < 30 + start_of_month_weekday
      puts if (counter % 7).zero?
      if i < day_of_month - 1
        print format('%-8.3s', '*')
        counter += 1
      else
        print  "#{day}\t".red if event_entries[day]
        print  "#{day}\t".green unless event_entries[day]
        counter += 1
        day += 1
      end
      i += 1
    end
  end
end
