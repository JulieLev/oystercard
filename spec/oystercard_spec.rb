require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe 'when new' do
    it 'journey history should be empty' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#balance' do
    it 'should check that a new card has a balance' do
      expect(subject).to respond_to(:balance)
    end

    it 'should have default value of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add money to balance' do
      expect { subject.top_up(5) }.to change { subject.balance }.by 5
    end

    it 'should throw an error, if balance is exceed limit' do
      limit = Oystercard::LIMIT
      expect { subject.top_up(91) }.to raise_error "Exceeds limit: #{limit}"
    end
  end

  context 'while in journey' do
    describe '#in_journey?' do
      it { is_expected.to respond_to(:in_journey?) }

      it 'should have default value of false' do
        expect(subject.in_journey?).to eq false
      end
    end

    describe '#touch_in' do
      it 'should return true' do
        subject.top_up(2)
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end

      it 'raises a minimum balance error' do
        min_fare = 'Balance below minimum fare'
        expect { subject.touch_in(entry_station) }.to raise_error min_fare
      end

      it 'should record the entry station' do
        subject.top_up(1)
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end
    end

    describe '#touch_out' do
      it { is_expected.to respond_to(:touch_out) }

      it 'should return nil' do
        expect(subject.touch_out(exit_station)).to be nil
      end

      it 'should deduct min fare from my card' do
        subject.top_up(1)
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it 'should record the exit station' do
        subject.top_up(1)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq exit_station
      end

      it 'stores a list of journeys' do
        subject.top_up(5)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journeys.length).to eq 1
      end
    end
  end
end
