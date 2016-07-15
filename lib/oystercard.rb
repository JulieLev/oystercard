require 'journey'

class Oystercard

  attr_accessor :journeys
  attr_reader :balance, :journey

  LIMIT = 90

  def initialize
    @balance = 0
    @journeys = []
    @journey = nil
  end

  def top_up(money)
    raise "Exceeds limit: #{LIMIT}" if check_limit(money)
    @balance += money
  end

  def in_journey?
    @journey
  end

  def touch_in(entry_station)
    raise 'Balance below minimum fare' if balance < Journey::MINIMUM_FARE
    @journey.finish if in_journey?
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    if !in_journey?
      @journey = Journey.new
    end
    @journey.finish(exit_station)
    record_journey
    deduct_fare
    @journey = nil
  end



  private

  def record_journey
    @journeys << @journey.record
  end

  def check_limit(money)
    (@balance + money) > LIMIT
  end

  def deduct_fare
    @balance -= @journey.fare
  end
end
