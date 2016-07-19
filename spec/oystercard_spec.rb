require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe 'when new, the card' do
    it 'journey history should be empty' do
      expect(card.journeys).to be_empty
    end

    it 'balance should have default value of 0' do
      expect(card.balance).to eq(0)
    end

    it 'should not be in a journey' do
      expect(card).not_to be_in_journey
    end
  end

  describe 'top_up' do
    it 'should add money to balance' do
      expect { card.top_up(5) }.to change { card.balance }.by 5
    end

    it 'should throw an error if balance would exceed the maximum limit' do
      limit = Oystercard::LIMIT
      expect { card.top_up(91) }.to raise_error "Exceeds limit: #{limit}"
    end
  end

  context 'when touching in and out' do
    describe 'it checks balance' do
      it 'raises an error if it has less than the minimum balance' do
        min_fare = 'Balance below minimum fare'
        expect { card.touch_in(entry_station) }.to raise_error min_fare
      end
    end

    describe 'after touch_in' do
      before(:each) do
        card.top_up(2)
        card.touch_in(entry_station)
      end

      it 'should be in a journey' do
        expect(card).to be_in_journey
      end

      # it 'should record the entry station' do
      #   expect(card.entry_station).to eq entry_station
      # end
    end

    describe 'at touch_out' do
      before(:each) do
        card.top_up(2)
        card.touch_in(entry_station)
      end
# This test is wrong...
      it 'should deduct the minimum fare from the balance' do
        minimum = Journey::MINIMUM_FARE
        expect { card.touch_out(exit_station) }.to change { card.balance }.by(-minimum)
      end

      before(:each) do
        card.touch_out(exit_station)
      end

      # it 'should record the exit station' do
      #   expect(subject.exit_station).to eq exit_station
      # end

      let(:journey) { { entry_station: entry_station, exit_station: exit_station , fare: fare} }
      it 'stores a list of journeys' do
        expect(card.journeys).to include journey
      end
    end # describe at touch_out
  end # context touch in and out
end # describe Oystercard
