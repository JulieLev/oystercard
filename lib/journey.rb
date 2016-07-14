require 'oystercard'
class Journey

  def add_journey
    journey = {}
    journey[:entry], journey[:exit] = entry_station, exit_station
    @journeys << journey
  end

end
