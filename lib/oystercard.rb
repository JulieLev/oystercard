require 'journey'

class Oystercard

  attr_accessor :journeys
  attr_reader :balance, :in_journey

  LIMIT = 90

  def initialize
    @balance = 0
    @journeys = []
    @in_journey = false
  end

  def top_up(money)
    raise "Exceeds limit: #{LIMIT}" if check_limit(money)
    @balance += money
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    raise 'Balance below minimum fare' if balance < Journey::MINIMUM_FARE
    @in_journey = true
    @journey = Journey.new(station)
  end

  def touch_out(station)
    @in_journey = false
    @journey.finish_journey(station)
  end

  private

  def check_limit(money)
    (@balance + money) > LIMIT
  end

  def deduct(money)
    @balance -= money
  end
end
