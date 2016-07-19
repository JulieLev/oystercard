require 'journey'
describe Journey do
  subject(:journey) { Journey.new }

  let(:entry_station) { double :station, zone: 1}
  let(:exit_station) { double :station, zone: 1}

  it "knows a new journey is not complete" do
    expect(journey).to be_incomplete
  end

  it 'has a penalty fare by default' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  # it "returns itself when exiting a journey" do
  #   expect(journey.finish(exit_station)).to eq(journey)
  # end

  it "returns a journey when adding a journey" do
    expect(journey.record).to eq(journey.current)
  end

  context 'given an entry station' do
    subject(:journey){Journey.new(entry_station)}

    it 'has an entry station' do
      expect(journey.entry_station).to eq entry_station
    end

    it "returns a penalty fare if no exit station given" do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:other_station) { double :other_station }

      before do
        journey.finish(other_station)
      end

      it 'calculates a fare' do
        expect(journey.fare).to eq 1
      end

      it "knows if a journey is complete" do
        expect(journey).not_to be_incomplete
      end
    end
  end
end
