class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number)
    super
    @type = 'Passenger'
  end

  def add_car(car)
    if car.instance_of?(PassengerCar)
      super(car)
    else
      puts 'К пассажирскому поезду можно прицепить только пассажирский вагон!'
    end
  end
end
