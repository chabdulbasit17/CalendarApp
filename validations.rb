# frozen_string_literal: true

# require_relative("event")
require('time')
require('date')
require 'io/console'

module Validations
  def self.press_enter
    print 'press enter to continue...'
    $stdin.getch
    print "            \r" # extra space to overwrite in case next sentence is short
    puts
  end

  def self.input_date
    date = gets
    begin
      Date.parse(date)
    rescue StandardError
      nil
    end
  end

  def self.input_time
    time = gets
    rettime = Validations.get_time(time)
    return Time.parse(rettime) unless rettime.nil?

    nil
  end

  def self.get_time(str)
    b = str.each_char.each_cons(5).find do |a|
      %w[0 1 2].include?(a.first) &&
        begin
          DateTime.strptime(a.join, '%H:%M')
        rescue StandardError
          nil
        end
    end
    b ? b.join : b
  end

  def self.input_integer
    gets.chomp.to_i
  rescue StandardError
    nil
  end
end
