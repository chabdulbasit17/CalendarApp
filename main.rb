# frozen_string_literal: true

require_relative('calendar')
require_relative('validations')
require_relative('csv')
require('date')
require('colorize')
require_relative('event')

# class Driver- main class
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
      system('clear') || system('cls')
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
    date = input_date_time('date')
    @calendar.month_view(date)
  end

  def day_view
    puts 'Please enter date (DD/MM/YYYY)'
    date = input_date_time('date')
    @calendar.day_view(date)
  end

  def delete_event
    month, event_index = select_event
    return if month.nil? || event_index.nil?

    if @calendar.delete_event(month, event_index)
      puts 'Successfully Deleted'.green
    else
      puts 'The event was not deleted. Please enter valid index'.red
    end
  end

  def update_event
    month, event_index = select_event
    return if event_index.nil? || month.nil?

    if @calendar.validate_event_index(month, event_index).nil?
      puts 'Invalid Index'.red
      return
    end
    title, venue, date, time = input_event
    if title == '' && date.nil? && time.nil? && venue == ''
      puts 'Event not changed'.red
      return
    end
    if @calendar.update_event(month, event_index, title, venue, date, time)
      puts 'Event successfully updated'.green
    else
      puts 'Error: Please enter correct index'.red
    end
  end

  def grid_view
    puts 'Please enter the date (MM/YYYY): '
    date = input_date_time('date')
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
    date = input_date_time('date')
    return if @calendar.month_view(date).nil?

    puts 'Please enter the index of event you want to remove'
    event_index = validate_integer gets.chomp
    [date.month, event_index]
  end

  def input_event
    puts 'Please enter the title: '
    title = input_string
    puts 'Please enter the venue: '
    venue = input_string
    puts 'Please enter the date(dd/mm/yyyy): '
    date = input_date_time('date')
    puts 'Please enter the time(HH:MM): '
    time = input_date_time('time')
    [title, venue, date, time]
  end

  def input_date_time(obj)
    ret_value = nil
    while ret_value.nil?
      ret_value = public_send("validate_#{obj}", gets.chomp)
      puts "Invalid #{obj}. Please try again".red if ret_value.nil?
    end
    ret_value
  end

  def input_string
    str = ''
    while str.empty?
      str = gets.chomp
      puts 'Please enter a valid value: '.red if str.empty?
    end
    str
  end

  def press_enter
    print 'press enter to continue...'
    $stdin.getch
    print "            \r" # extra space to overwrite in case next sentence is short
    puts
  end
end

Driver.new.run