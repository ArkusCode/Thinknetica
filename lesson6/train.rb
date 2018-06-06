class Train

  include Manufacturer
  include InstanceCounter
  include Valid

  attr_accessor :number, :cars, :speed, :route, :cur_st
  attr_reader :type
  @@trains_all = {}
  NUMBER_FORMAT = /^[a-zа-я\d]{3}-*[a-zа-я\d]{2}$/i

  def initialize(number)
    @number = number
    @cars = []
    @speed = 0
    validate!
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

  def validate!
    raise "Поезд с таким номером уже создан!" unless Train.find(number).nil?
    raise "Неверный формат номера!" if number !~ NUMBER_FORMAT
    true
  end
end
