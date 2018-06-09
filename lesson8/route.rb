class Route
  include InstanceCounter
  include Validate

  attr_accessor :stations, :from, :to

  def initialize(from, to)
    @from = from
    @to = to
    validate!
    @stations = [from, to]
    register_instance
  end

  def add(station)
    stations.insert(-2, station)
  end

  def remove(station)
    stations.delete(station)
  end

  def show_route
    @stations
  end

  def validate!
    raise 'Станция отправления совпадает со станцией прибытия!' if from == to
    true
  end
end
