# frozen_string_literal: true

require_relative('calendar')
require_relative('validations')
require_relative('csv')
require('date')
require('colorize')
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
      flag = validate_integer gets.chomp
      if !flag.between?(1, 8)
        puts 'Invalid Choice !'.red
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
      elsif flag == 7
        load_from_csv
      end
      press_enter

    end
  end

  def add_event
    title, venue, date, time = input_event
    if @calendar.add_event(date, time, title, venue)
      puts 'Successfully added.'.green
    else
      puts 'Event was not added.'.red
    end
  end

  def month_view
    puts 'Please enter date (MM/YYYY)'
    date = input_date
    @calendar.month_view(date.month, date.year)
  end

  def day_view
    puts 'Please enter date (DD/MM/YYYY)'
    date = input_date
    @calendar.day_view(date)
  end

  def delete_event
    month, ind = select_event
    return if month.nil? || ind.nil?

    if @calendar.delete_event(month, ind)
      puts 'Successfully Deleted'.green
    else
      puts 'The event was not deleted. Please enter valid index'.red
    end
  end

  def update_event
    month, ind = select_event
    return if ind.nil? || month.nil?

    title, venue, date, time = input_event
    if title == '' && date.nil? && time.nil? && venue == ''
      puts 'Event not changed'.red
      return
    end
    if @calendar.update_event(month, ind, title, venue, date, time)
      puts 'Event successfully updated'.green
    else
      puts 'Error: Please enter correct index'.red
    end
  end

  def grid_view
    puts 'Please enter the date (MM/YYYY): '
    date = input_date
    @calendar.grid_view(date)
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

  def load_from_csv
    puts 'Please enter filename: (filename.csv) '
    filename = input_string
    data = Csv.new.load_data(filename)
    # date, time, title, venue
    if data.nil?
      puts 'The file mentioned doesnt exist'.red
      return
    end
    data.each do |eve|
      date, time, title, venue = eve
      date = validate_date(date.chomp)
      time = validate_time(time.chomp)
      puts 'Error in data' && break if date.nil? || time.nil?
      @calendar.add_event(date, time, title, venue, false)
    end
    puts 'Data has been loaded into the calendar from the file'.green
  end

  # Helpers

  private

  def select_event
    print 'Please enter date: (MM/YYYY)'
    date = input_date
    return if @calendar.month_view(date.month, date.year).nil?

    puts 'Please enter the index of event you want to remove'
    ind = validate_integer gets.chomp
    [date.month, ind]
  end

  def input_event
    puts 'Please enter the title: '
    title = input_string
    puts 'Please enter the venue: '
    venue = input_string
    puts 'Please enter the date(dd/mm/yyyy): '
    date = input_date
    puts 'Please enter the time(HH:MM): '
    time = input_time
    [title, venue, date, time]
  end

  def input_date
    date = nil
    while date.nil?
      date = validate_date gets.chomp
      puts 'Invalid Date. Please Try Again: '.red if date.nil?
    end
    date
  end

  def input_time
    time = nil
    while time.nil?
      time = validate_time gets.chomp
      puts 'Invalid Time. Please Try Again: '.red if time.nil?
    end
    time
  end

  def input_string
    str = ''
    while str.empty?
      str = gets.chomp
      puts 'Please enter a valid value: '.red if str.empty?
    end
    str
  end
end

Driver.new.run