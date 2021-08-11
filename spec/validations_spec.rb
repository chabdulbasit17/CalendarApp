# frozen_string_literal: true

require('./validations')
require('date')
require('time')

describe Validations do
  let(:dummy_class) { Class.new { extend Validations } }

  it 'returns a valid Date object when passed a string' do
    expect(dummy_class.validate_date('26/08/2021')).to eq Date.parse('26/08/2021')
  end

  it 'returns a valid Time object when passed a string' do
    expect(dummy_class.validate_time('12:30')).to eq Time.parse('12:30')
  end

  it 'returns a valid integer converted from a string' do
    expect(dummy_class.validate_integer('10')).to eq '10'.to_i
  end

  it 'returns nil if wrong format of date is given' do
    expect(dummy_class.validate_date("2/8/21")).to eq nil
  end

  it 'returns nil if wrong format of time is given' do
    expect(dummy_class.validate_time("2:2")).to eq nil
  end
end
