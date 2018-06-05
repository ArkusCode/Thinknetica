class Route

  include InstanceCounter

  attr_accessor :stations, :from, :to

  def initialize(from, to)
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
end
