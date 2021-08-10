# frozen_string_literal: true

require_relative('calendar')
require_relative('validations')
require('date')
require_relative('event')

class Driver
  include Validations
  def initialize
    @calendar = Calendar.new
  end

  def run
    flag = 0
    while flag != 8
      show_main_menu
      flag = Validations.input_integer
      if !flag.between?(1, 8)
        puts 'Invalid Choice !'
      elsif flag == 1
        grid_view
      elsif flag == 2
        add_event
      elsif flag == 3
        delete_event
      elsif flag == 4
        update_event
      elsif flag == 5
        month_view
      elsif flag == 6
        day_view

      end
      Validations.press_enter

    end
  end

  def add_event
    title, venue, date, time = Event.input_event
    if @calendar.add_event(date, time, title, venue)
      puts 'Successfully added.'
    else
      puts 'Event was not added.'
    end
  end

  def month_view
    puts "Please enter the month's full name: (i.e) August"
    mth = gets.chomp.capitalize
    month = Date::MONTHNAMES.index(mth)
    if month.nil?
      puts 'Invalid month name.'
      return
    end
    puts 'Please enter the year: '
    year = Validations.input_integer
    if year.zero?
      puts 'Invalid year'
      return
    end
    @calendar.month_view(month, year)
  end

  def day_view
    puts 'Please enter date'
    date = Validations.input_date
    puts 'Invalid date' && return if date.nil?
    @calendar.day_view(date)
  end

  def delete_event
    month, ind = select_event
    return if month.nil? || ind.nil?

    if @calendar.delete_event(month, ind)
      puts 'Successfully Deleted'
    else
      puts 'The event was not deleted. Please enter valid index'
    end
  end

  def update_event
    month, ind = select_event
    return if ind.nil? || month.nil?

    puts 'Press enter if value should not be changed...'
    title, venue, date, time = Event.input_event
    if title == '' && date.nil? && time.nil? && venue == ''
      puts 'Event not changed'
      return
    end
    @calendar.update_event(month, ind, title, venue, date, time)
  end

  def grid_view
    @calendar.grid_view
  end

  def show_main_menu
    puts "Welcome ! Today is #{Time.new.day}/#{Time.new.month}/#{Time.new.year} "
    puts "1-- View the whole month\n"
    puts "2-- Add Event\n"
    puts "3-- Remove Event\n"
    puts "4-- Update Event\n"
    puts "5-- Show events of a specific month\n"
    puts "6-- Show events of a specific day\n"
    puts "7-- Load From A File\n"
    puts "8-- Exit App\n"
  end

  # Helpers

  private

  def select_event
    puts "Please enter the month's full name: (i.e) August"
    mth = gets.chomp.capitalize
    month = Date::MONTHNAMES.index(mth)
    if month.nil?
      puts 'Invalid month name.'
      return
    end
    return if @calendar.month_view(month).zero?

    puts 'Please enter the index of event you want to remove'
    ind = Validations.input_integer
    [month, ind]
  end
end

dr = Driver.new

dr.run
