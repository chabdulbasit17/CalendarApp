# frozen_string_literal: true

require 'csv'

# Reading from CSV files
class Csv
  def load_data(filename)
    CSV.read(filename)
  end
end
