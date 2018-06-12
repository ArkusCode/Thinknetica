class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number)
    super
    @type = 'Cargo'
  end

  def add_car(car)
    if car.instance_of?(CargoCar)
      super(car)
    else
      puts 'К грузовому поезду можно прицеплять только грузовые вагоны!'
    end
  end
end
