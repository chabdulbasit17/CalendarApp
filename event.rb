# frozen_string_literal: true

require_relative('validations')

class Event
  include Validations
  attr_accessor :date, :time, :venue, :title

  def initialize(date, time, venue, title)
    @date = date
    @time = time
    @venue = venue
    @title = title
  end

  def self.input_event
    puts 'Please enter the title: '
    title = gets.chomp
    puts 'Please enter the venue: '
    venue = gets.chomp
    puts 'Please enter the date(dd/mm/yyyy): '
    date = Validations.input_date
    puts 'Please enter the time(HH:MM): '
    time = Validations.input_time
    [title, venue, date, time]
  end
end
