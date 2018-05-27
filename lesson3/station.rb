class Station

  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = [] 
  end

  def get_train(train)
    @trains << train
    puts "На станцию #{@name} прибыл поезд № #{train.number}."
  end

  def list
    @trains.each {|train| puts "Поезд № #{train.number}, тип: #{train.type}."}
  end

  def send_train(train)
    @trains.delete(train)
    puts "Со станции #{@name} отправился поезд № #{train.number}."
  end
end

class Route

  attr_accessor :stations, :from, :to

  def initialize(from, to)
  @stations = [from, to]
    puts "Создан маршрут #{stations.first.name} - #{stations.last.name}"
  end

  def add(station)
    self.stations.insert(-2, station)
    puts "Добавленна промежуточная остановка на станции #{station.name}"
  end

  def remove(station)
    if self.stations.first == station || self.stations.last == station
      puts "Вы не можете удалить начальную или конечную станцию маршрута!"
    else
      self.stations.delete(station)
      puts "Из текущего маршрута убрана станция #{station.name}"
    end
  end

  def show_route
    puts "В маршрут #{stations.first.name} - #{stations.last.name} входят: "
    stations.each.with_index(1) do |st, index|
      puts "#{index}: #{st.name}"
    end
  end
end

class Train

  attr_accessor :number, :cargo_count, :speed, :route, :cur_st
  attr_reader :type

  def initialize(number, type, cargo_count)
    @number = number
    @type = type
    @cargo_count = cargo_count
    @speed = 0
  end

  def train_stop
    self.speed = 0
    puts "Поезд № #{number} cтоит!"
  end

  def cargo_add
    self.train_stop
    self.cargo_count += 1
  end

  def cargo_remove
    if cargo_count.zero?
      puts "Вагонов уже нет!"
    else
      self.train_stop
      self.cargo_count -= 1
    end
  end

  def set_route(route)
    self.route = route
    puts "Поезду #{number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}."
    route.stations.first.get_train(self)
  end

  def current_station
    @cur_st = route.stations.detect { |t| t.trains.include?(self) }
    if @cur_st.nil?
      puts "Поезду № #{number} все еще не назначен маршрут!"
    else
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
    if current_station == route.stations.last
      puts "Поезд № #{number} уже прибыл на конечную станцию маршрута #{current_station.name}"
    else
      current_station.send_train(self)
      next_station.get_train(self)
    end
  end

  def move_previous_station
    if current_station == route.stations.first
      puts "Поезд № #{number} уже прибыл на начальную станцию маршрута #{current_station.name}"
    else
      current_station.send_train(self)
      previous_station.get_train(self)
    end
  end
end
