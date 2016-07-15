require 'oystercard'
require 'station'
require 'journey'

describe '* journey working feature test *' do
card = Oystercard.new
card.top_up(20)

hoxton = Station.new(name: "Hoxton", zone: 1)
shoreditch = Station.new(name: "Shoreditch", zone: 1)
bank = Station.new(name: "Bank", zone: 1)

card.touch_in(hoxton)

card.touch_out(shoreditch)

it 'stores a list of journeys' do
  expect(card.journeys[0]).to include(entry_station: hoxton, exit_station: shoreditch)
end

card.touch_in(shoreditch)


end



#puts card.journeys[0]
