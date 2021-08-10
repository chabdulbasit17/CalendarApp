# frozen_string_literal: true

# require_relative("event")
require('time')
require('date')
require 'io/console'
# Validations for validations and helper methods
module Validations
  def press_enter
    print 'press enter to continue...'
    $stdin.getch
    print "            \r" # extra space to overwrite in case next sentence is short
    puts
  end

  def validate_date(date)
    Date.parse(date)
  rescue StandardError
    nil
  end

  def validate_time(time)
    rettime = get_time(time)
    return Time.parse(rettime) unless rettime.nil?

    nil
  end

  def validate_integer(num)
    num.to_i
  rescue StandardError
    nil
  end
end

private

def get_time(str)
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
