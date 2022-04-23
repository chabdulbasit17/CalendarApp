# frozen_string_literal: true

require 'csv'

# Reading from CSV files
class Csv
  def load_data(filename)
    CSV.read(filename)
  rescue Errno::ENOENT
    nil
  end
end
