require 'oystercard'
require 'station'
require 'journey'

describe '* journey working feature test *' do
card = Oystercard.new
card.top_up(10)

hoxton = Station.new(name: "Hoxton", zone: 1)
shoreditch = Station.new(name: "Shoreditch", zone: 1)
bank = Station.new(name: "Bank", zone: 1)

card.touch_in(hoxton)
card.touch_out(shoreditch)

it 'adds the entry station to the journeys history array' do
  expect(card.journeys[0]).to include(entry_station: hoxton)
end

it 'adds the exit station to the journeys history array' do
  expect(card.journeys[0]).to include(exit_station: shoreditch)
end

it 'adds the fare to the journeys history array' do
  expect(card.journeys[0]).to include(fare: Journey::MINIMUM_FARE)
end

it 'deducts the right fare from the balance' do
  expect(card.balance).to eq 9
end

card.touch_in(shoreditch)
card.touch_in(hoxton)

it 'adds the entry station to the journeys history array' do
  expect(card.journeys[1]).to include(entry_station: shoreditch)
end

it 'adds the exit station to the journeys history array' do
  expect(card.journeys[1]).to include(exit_station: nil)
end

it 'adds the fare to the journeys history array' do
  expect(card.journeys[1]).to include(fare: Journey::PENALTY_FARE)
end

card.touch_out(shoreditch)
card.touch_out(bank)

it 'adds the entry station to the journeys history array' do
  expect(card.journeys[3]).to include(entry_station: nil)
end

it 'adds the exit station to the journeys history array' do
  expect(card.journeys[3]).to include(exit_station: bank)
end

it 'adds the fare to the journeys history array' do
  expect(card.journeys[3]).to include(fare: Journey::PENALTY_FARE)
end

end



#puts card.journeys[0]
