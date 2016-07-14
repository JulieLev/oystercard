require 'oystercard'
require 'station'
require 'journey'

describe 'journey working feature' do
card = Oystercard.new
card.top_up(20)

hoxton = Station.new(name: "Hoxton", zone: 1)
shoreditch = Station.new(name: "Shoreditch", zone: 1)
bank = Station.new(name: "Bank", zone: 1)

card.touch_in(hoxton)

it 'is in a journey' do
  expect(card).to be_in_journey
end
it 'is in a journey' do
  expect(card.in_journey?).to be true
end

card.touch_out(shoreditch)

it 'the journey has finished' do
  expect(card.in_journey?).to be false
end
it 'the journey has finished' do
  expect(card).not_to be_in_journey
end

it 'stores a list of journeys' do
  expect(card.journeys[0]).to include(entry: hoxton, exit: shoreditch)
end

card.touch_in(shoreditch)

it 'is in a journey' do
  expect(card).to be_in_journey
end

end



#puts card.journeys[0]
