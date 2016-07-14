require 'station'

describe Station do
  subject {described_class.new(name: "Hoxton", zone: 1)}

  it 'has a name' do
    expect(subject.name).to eq("Hoxton")
  end

  it 'is in a zone' do
    expect(subject.zone).to eq(1)
  end
end
