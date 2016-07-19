require 'oystercard'

class Journey
  attr_reader :record
  attr_reader :entry_station, :exit_station, :fare, :current

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @current = {}
    @entry_station = entry_station
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    record
  end

  def record
    @current[:entry_station] = @entry_station
    @current[:exit_station] = @exit_station
    @current[:fare] = fare
    @current
  end

  def incomplete?
    !(@entry_station && @exit_station)
  end

  def fare
    return PENALTY_FARE if incomplete?
    MINIMUM_FARE
  end
end
