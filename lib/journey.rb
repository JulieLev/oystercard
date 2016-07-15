require 'oystercard'

class Journey
  attr_accessor :journey
  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @journey = {}
    @entry_station = entry_station
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
  end

  def add_journey
    journey[:entry_station] = @entry_station
    journey[:exit_station] = @exit_station
    journey
  end

  def incomplete?
    !(@entry_station && @exit_station)
  end

  def fare
    return PENALTY_FARE if incomplete?
    MINIMUM_FARE
  end
end
