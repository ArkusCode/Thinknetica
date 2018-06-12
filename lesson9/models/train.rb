class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor :number, :cars, :route, :cur_st
  attr_reader :type
  attr_accessor_with_history :speed
  strong_attr_accessor :home_station, Station
  @@trains_all = {}
  NUMBER_FORMAT = /^[a-zа-я\d]{3}-*[a-zа-я\d]{2}$/i

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @type_class = self.class
    @number = number
    @cars = []
    self.speed = 0
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
    train_stop
    cars << car
  end

  def remove_car(car)
    train_stop
    cars.delete(car)
  end

  def on_route(route)
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

  def iterate_cars
    raise 'В этом поезде нет ни одного вагона!' if @cars.empty?
    @cars.each { |car| yield(car) }
  end
end
