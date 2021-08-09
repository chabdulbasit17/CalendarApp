require_relative("event")
require("time")
require("date")

module Validations
 
  def Validations.input_date
    date = gets
    retdate = Date.parse(date) rescue nil
    return retdate
  end

  def Validations.input_time
    time = gets
    rettime = Validations.get_time(time)
    return Time.parse(rettime) unless rettime.nil?
    return nil
  end

  def Validations.get_time(str)
    b = str.each_char.each_cons(5).find { |a| ['0', '1', '2'].include?(a.first) &&
      (DateTime.strptime(a.join, '%H:%M') rescue nil) }
    b ? b.join : b
  end

  def Validations.input_integer
    num = gets.chomp.to_i rescue nil
  end

end

