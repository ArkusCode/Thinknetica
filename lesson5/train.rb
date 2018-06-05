class Train

  include Manufacturer
  include InstanceCounter

  attr_accessor :number, :cars, :speed, :route, :cur_st
  attr_reader :type
  @@trains_all = {}

  def initialize(number)
    @number = number
    @cars = []
    @speed = 0
    @@trains_all[number] = self
    register_instance
  end

  def self.find(number)
    @@trains_all[number]
  end

  def train_stop
    self.speed = 0
  end

  def add_car(car)
    self.train_stop
    self.cars << car
  end

  def remove_car(car)
    self.train_stop
    self.cars.delete(car)
  end

  def set_route(route)
    self.route = route
    route.stations.first.get_train(self)
  end

  def current_station
    @cur_st = route.stations.detect { |t| t.trains.include?(self) }
  end

  def next_station
    curr_index = route.stations.index(@cur_st)
    route.stations[curr_index + 1]
  end

  def previous_station
    curr_index = route.stations.index(@cur_st)
    route.stations[curr_index - 1]
  end

  def move_next_station
    current_station.send_train(self)
    next_station.get_train(self)
  end

  def move_previous_station
    current_station.send_train(self)
    previous_station.get_train(self)
  end
end
