class Route

  include InstanceCounter
  include Valid

  attr_accessor :stations, :from, :to

  def initialize(from, to)
    @from = from
    @to = to
    validate!
    @stations = [from, to]
    register_instance
  end

  def add(station)
    self.stations.insert(-2, station)
  end

  def remove(station)
    self.stations.delete(station)
  end

  def show_route
    @stations
  end

  def validate!
    raise "Станция отправления не должна совпадать со станцией прибытия!" if from == to
    true
  end
end
