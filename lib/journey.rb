require 'oystercard'

class Journey
  attr_accessor :journey
  attr_reader :finish_journey #, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station = nil)
    @journey = {}
    @entry_station = station
  end

  def finish_journey(station = nil)
    @exit_station = station
    add_journey
    calculate_fare
  end

  def add_journey
    journey[:entry] = @entry_station
    journey[:exit] = @exit_station
    @journeys << journey
    #journey.ended = false
  end

  def calculate_fare
    return MINIMUM_FARE if @entry_station && @exit_station
    PENALTY_FARE
  end
end
