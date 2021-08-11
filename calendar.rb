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
    puts 'Error in date' && return if date.nil?

    puts 'Error in time' && return if time.nil?

    if date.year < Time.new.year && past_flag
      puts 'Cannot add event in the past'
      return
    end

    event_to_add = Event.new(date, time, title, venue)
    return true unless @events[date.month].push(event_to_add).nil?
  end

  def month_view(month, year)
    arr = []

    if @events[month].empty?
      puts 'No events for this month.'
      return nil
    end
    puts "Events for the month #{Date::MONTHNAMES[month]}"

    @events[month].each { |v| arr.push(v) if v.date.year == year }
    View.show_events(arr)
  end

  def day_view(date)
    arr = []
    month = date.month
    @events[month].each { |v| arr.push(v) if v.date.year == date.year && v.date.day == date.day }
    View.show_events(arr)
  end

  def grid_view(entered_date)
    date = Date.parse("01/#{entered_date.month}/#{entered_date.year}")
    puts 'Invalid date' && return if date.nil?
    start_weekday = date.cwday
    event_entries = Hash.new(0)
    @events[date.month].each { |v| event_entries[v.date.day] += 1 if v.date.year == date.year }
    View.grid_view(start_weekday, event_entries)
  end

  def delete_event(month, index)
    return nil if index > @events[month].size || index < 1

    return true unless @events[month].delete_at(index - 1).nil?
  end

  def update_event(month, index, *event)
    title, venue, date, time = event
    return nil if index > @events[month].size || index < 1

    if add_event(date, time, venue, title)
      delete_event(month, index)
      true
    else
      false
    end
  end
end
