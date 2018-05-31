class Train

  attr_accessor :number, :cars, :speed, :route, :cur_st
  attr_reader :type

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
  end

  def train_stop
    self.speed = 0
    puts "Поезд № #{number} cтоит!"
  end

  def add_car(car)
    self.train_stop
    self.cars << car
    puts "К поезду № #{number} прицеплен вагон #{car}"
  end

  def remove_car(car)
    if !cars.include?(car)
      puts "Такого вагона, нет в этом поезде!"
    else
      self.train_stop
      self.cars.delete(car)
      puts "От поезда № #{number} отцеплен вагон #{car}" 
    end
  end

  def set_route(route)
    self.route = route
    puts "Поезду № #{number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}."
    route.stations.first.get_train(self)
  end

  def current_station
    if self.route.nil?
      puts "Поезду № #{number} все еще не назначен маршрут!"
    else
      @cur_st = route.stations.detect { |t| t.trains.include?(self) }
      @cur_st
    end
  end

  def next_station
    curr_index = route.stations.index(@cur_st)
    if curr_index != route.stations.size - 1
      route.stations[curr_index + 1]
    else
      puts "Поезд № #{number} уже прибыл на конечную станцию маршрута #{current_station.name}"
    end
  end

  def previous_station
    curr_index = route.stations.index(@cur_st)
    if curr_index != 0
      route.stations[curr_index - 1]
    else
      puts "Поезд № #{number} уже прибыл на начальную станцию маршрута #{current_station.name}"
    end
  end

  def move_next_station
    if self.route.nil?
      puts "Поезду № #{number} еще не назначен маршрут."
    elsif current_station == route.stations.last
      puts "Поезд № #{number} уже прибыл на конечную станцию маршрута #{current_station.name}"
    else
      current_station.send_train(self)
      next_station.get_train(self)
    end
  end

  def move_previous_station
    if self.route.nil?
      puts "Поезду № #{number} еще не назначен маршрут."
    elsif current_station == route.stations.first
      puts "Поезд № #{number} уже прибыл на начальную станцию маршрута #{current_station.name}"
    else
      current_station.send_train(self)
      previous_station.get_train(self)
    end
  end
end
