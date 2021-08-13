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
    option_selected_by_user = 0
    while option_selected_by_user != 8
      show_main_menu
      option_selected_by_user = validate_integer(gets.chomp)
      if !option_selected_by_user.between?(1, 8)
        puts 'Invalid Choice !'.red
      elsif option_selected_by_user == 1
        show_calendar_view_of_month
      elsif option_selected_by_user == 2
        add_event
      elsif option_selected_by_user == 3
        delete_event
      elsif option_selected_by_user == 4
        update_event
      elsif option_selected_by_user == 5
        show_events_of_a_month
      elsif option_selected_by_user == 6
        show_events_of_a_day
      elsif option_selected_by_user == 7
        load_events_from_csv_file
      end
      press_enter_to_continue
    end
  end

  def add_event
    title, venue, date, time = get_event_input
    if @calendar.add_event(date, time, title, venue)
      puts 'Successfully added.'.green
    else
      puts 'Event was not added.'.red
    end
  end

  def show_events_of_a_month
    puts 'Please enter date (MM/YYYY)'
    date = get_date_time_input(:date)
    @calendar.month_view(date)
  end

  def show_events_of_a_day
    puts 'Please enter date (DD/MM/YYYY)'
    date = get_date_time_input(:date)
    @calendar.day_view(date)
  end

  def delete_event
    month, event_index = show_events_and_get_index
    return if month.nil? || event_index.nil?

    if @calendar.delete_event(month, event_index)
      puts 'Successfully Deleted'.green
    else
      puts 'The event was not deleted. Please enter valid index'.red
    end
  end

  def update_event
    month, event_index = show_events_and_get_index
    if !@calendar.valid_event_index?(month, event_index)
      puts 'Invalid Index'.red
      return
    end
    title, venue, date, time = get_event_input
    if @calendar.update_event(month, event_index, title, venue, date, time)
      puts 'Event successfully updated'.green
    else
      puts 'Error: Please enter correct index'.red
    end
  end

  def show_calendar_view_of_month
    puts 'Please enter the date (MM/YYYY): '
    date = get_date_time_input(:date)
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

  def load_events_from_csv_file
    puts 'Please enter filename: (filename.csv) '
    filename = get_string_input
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

  def show_events_and_get_index
    print 'Please enter date: (MM/YYYY)'
    date = get_date_time_input('date')
    return if @calendar.month_view(date).nil?

    puts 'Please enter the index of event you want to remove'
    event_index = validate_integer(gets.chomp)
    [date.month, event_index]
  end

  def get_event_input
    puts 'Please enter the title: '
    title = get_string_input
    puts 'Please enter the venue: '
    venue = get_string_input
    puts 'Please enter the date(dd/mm/yyyy): '
    date = get_date_time_input(:date)
    puts 'Please enter the time(HH:MM): '
    time = get_date_time_input(:time)
    [title, venue, date, time]
  end

  def get_date_time_input(object_type)
    date_time_to_return = nil
    while date_time_to_return.nil?
      date_time_to_return = public_send("validate_#{object_type}", gets.chomp)
      # Public send calls either validate_date or validate_time based on the @param object_type
      puts "Invalid #{object_type}. Please try again".red if date_time_to_return.nil?
    end
    date_time_to_return
  end

  def get_string_input
    str = ''
    while str.empty?
      str = gets.chomp
      puts 'Please enter a valid value: '.red if str.empty?
    end
    str
  end

  def press_enter_to_continue
    print 'press enter to continue...'
    $stdin.getch
    print "            \r" # extra space to overwrite in case next sentence is short
    puts
    system('clear')
  end
end

Driver.new.run
