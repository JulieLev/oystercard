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

context ' after one successful journey...' do
  it 'adds the entry station to the journeys history array' do
    expect(card.journeys[0]).to include(entry_station: hoxton)
  end

  it 'adds the exit station to the journeys history array' do
    expect(card.journeys[0]).to include(exit_station: shoreditch)
  end

  it 'adds the fare to the journeys history array' do
    expect(card.journeys[0]).to include(fare: Journey::MINIMUM_FARE)
  end

  it 'deducts the minimum fare from the balance' do
    expect(card.balance).to eq 19
    #expect(card.balance).to change card.balance.by(-minimum)
  end
end # end context

card.touch_in(shoreditch)
card.touch_in(hoxton)

context 'after one success, one unfinished, plus a touch in' do
  it 'adds the 2nd entry station to the 2nd journeys history array' do
    expect(card.journeys[1]).to include(entry_station: shoreditch)
  end

  it 'adds nil exit station to the 2nd journeys history array' do
    expect(card.journeys[1]).to include(exit_station: nil)
  end

  it 'adds the penalty fare to the 2nd journeys history array' do
    expect(card.journeys[1]).to include(fare: Journey::PENALTY_FARE)
  end

  it 'further deducts two penalty fares from the balance' do
    expect(card.balance).to eq 6
  end
end # end context

card.touch_out(shoreditch)
card.touch_out(bank)

context 'after the above (two good, one bad) plus one further touch out' do
  it 'adds the entry station to the journeys history array' do
    expect(card.journeys[3]).to include(entry_station: nil)
  end

  it 'adds the exit station to the journeys history array' do
    expect(card.journeys[3]).to include(exit_station: bank)
  end

  it 'adds the fare to the journeys history array' do
    expect(card.journeys[3]).to include(fare: Journey::PENALTY_FARE)
  end

  it 'further deducts a penalty fares from the balance' do
    expect(card.balance).to eq 6
  end
end

end



#puts card.journeys[0]
