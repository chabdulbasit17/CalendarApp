# frozen_string_literal: true

require('./calendar')

RSpec.describe Calendar do
  before(:example) do
    @cal = Calendar.new
    @cal.add_event(Date.parse('26/08/2021'), Time.parse('1:30'), 'Meeting', 'Lahore')
  end

  it 'returns success on add_event called' do
    expect(@cal.add_event(Date.parse('26/08/2021'), Time.parse('1:30'), 'Meeting', 'Lahore')).to eq true
  end

  it 'deletes the specified event and array size reduces by one after successful deletion' do
    expect(@cal.delete_event(8, 1)).to eq true
  end

  it 'updates an event ' do
    expect(@cal.update_event(8, 1, 'Title2', 'Venue2', Date.parse('25/08/2021'), Time.parse('2:30'))).to eq true
  end

  it 'returns false if try to delete an event that doesnt exist' do
    expect(@cal.delete_event(8, 5)).to eq false
  end

  it 'returns false if try to update an event that doesnt exist' do
    expect(@cal.update_event(8, 5)).to eq false
  end
end
