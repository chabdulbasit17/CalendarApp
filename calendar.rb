# frozen_string_literal: true

require_relative('validations')
require_relative('event')
require('date')
require_relative('view')

# class Calendar
class Calendar
  include Validations
  def initialize
    @events = Hash.new { |h, k| h[k] = [] }
  end

  def add_event(date, time, venue, title, past_flag = true)
    if date.year < Time.new.year && past_flag
      puts 'Cannot add event in the past'
      return false
    end

    event_to_add = Event.new(date, time, title, venue)
    return true unless @events[date.month].push(event_to_add).nil?

    false
  end

  def month_view(date)
    if @events[date.month].empty?
      puts 'No events for this month.'
      return nil
    end
    puts "Events for the month #{Date::MONTHNAMES[date.month]}"

    filtered_events = @events[date.month].select { |event| event.date.year == date.year }
    View.show_events(filtered_events)
  end

  def day_view(date)
    if @events[date.month].empty?
      puts 'No events for this day.'
      return nil
    end
    month = date.month
    filtered_events = @events[month].select { |event| event.date.year == date.year && event.date.day == date.day }
    View.show_events(filtered_events)
  end

  def grid_view(entered_date)
    date = Date.parse("01/#{entered_date.month}/#{entered_date.year}")
    puts 'Invalid date' && return if date.nil?
    start_weekday = date.cwday
    events_on_a_day = Hash.new(0)
    @events[date.month].each { |event| events_on_a_day[event.date.day] += 1 if event.date.year == date.year }
    View.grid_view(start_weekday, events_on_a_day)
  end

  def delete_event(month, index)
    return false unless valid_event_index?(month, index)

    return true unless @events[month].delete_at(index - 1).nil?
  end

  def update_event(month, index, *event)
    title, venue, date, time = event
    return false unless valid_event_index?(month, index)

    if add_event(date, time, venue, title)
      delete_event(month, index)
      true
    else
      false
    end
  end

  def valid_event_index?(month, index)
    return false if index > @events[month].size || index < 1

    true
  end
end
