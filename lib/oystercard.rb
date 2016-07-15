require 'journey'

class Oystercard

  attr_accessor :journeys
  attr_reader :balance, :journey

  LIMIT = 90

  def initialize
    @balance = 0
    @journeys = []
    @journey = false
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
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    @journeys << @journey.add_journey
  end

  private

  def check_limit(money)
    (@balance + money) > LIMIT
  end

  def deduct(money)
    @balance -= money
  end
end
