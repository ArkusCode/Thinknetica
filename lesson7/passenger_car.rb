class PassengerCar < Car

  attr_reader :filled, :type

  def initialize(seats)
    @seats = seats
    @type = "Passenger"
    @filled = 0
  end

  def take_seats
    raise "Все места заняты!" if @filled == @seats
    @filled += 1
  end

  def free
    @seats - @filled
  end
end
