module RailRoadUI
  include SelectionUI

  protected

  CAR_TYPES = { 'Cargo' => CargoCar, 'Passenger' => PassengerCar }.freeze
  TRAIN_TYPES = { 1 => PassengerTrain, 2 => CargoTrain }.freeze

  def station_create
    p 'Введите название новой станции'
    station_name = gets.chomp
    if @stations.any? { |s| s.name == station_name } || station_name.empty?
      p 'Станция не создана: пустое название, либо станция уже создана.'
    else
      @stations << Station.new(station_name)
    end
  end

  def train_create
    p 'Введите номер поезда в формате ХХХХХ или ХХХ-ХХ'
    number = gets.chomp.to_s
    p "Для создания пассажирского поезда введите '1', для грузового '2'."
    type_choice = gets.chomp.to_i
    TRAIN_TYPES[type_choice].new(number)
  rescue StandardError => e
    p e.message
    retry
  end

  def create_route
    if @stations.size < 2
      p 'Cоздайте хотя бы пару станций'
    else
      stations_list
      p 'Введите номер начальной станции маршрута: '
      first_station = @stations[id_user_prompt(@stations.size)]
      p 'Введите номер конечной станции маршрута: '
      end_station = @stations[id_user_prompt(@stations.size)]
      @routs << Route.new(first_station, end_station)
      p "Создан маршрут #{first_station.name} - #{end_station.name}"
    end
  end

  def add_to_route
    route = route_choice
    station = station_choice
    route.add(station)
    p "Добавленна промежуточная остановка на станции #{station.name}"
  end

  def delete_from_route
    route = route_choice
    p "В маршруте #{route.stations.first.name} - #{route.stations.last.name}:"
    route.show_route.each.with_index(1) { |st, i| p "#{i}: #{st.name}" }
    station = route.stations[id_user_prompt(route.stations.size)]
    if [route.stations.first, route.stations.last].include?(station)
      p 'Вы не можете удалить начальную или конечную станцию маршрута!'
    else
      route.remove(station)
      p "Из текущего маршрута убрана станция #{station.name}"
    end
  end

  def show_all_route
    @routs.each do |r|
      p "В маршрут #{r.stations.first.name} - #{r.stations.last.name} входят: "
      r.show_route.each.with_index(1) { |s, i| p "#{i}: #{s.name}" }
    end
  end

  def train_set_route
    train = train_choice
    route = route_choice
    train.on_route(route)
    p "Поезду № #{train.number} задан маршрут " \
      " #{route.stations.first.name} - #{route.stations.last.name}."
  end

  def train_add_car
    train = train_choice
    if train.type == 'Cargo'
      p 'Введите объем вагона:'
      size = gets.chomp.to_f
    elsif train.type == 'Passenger'
      p 'Введите кол-во мест в вагоне:'
      size = gets.chomp.to_i
    end
    train.add_car(CAR_TYPES[train.type].new(size))
    p "Поезду № #{train.number} прицеплен вагон."
  rescue RuntimeError => e
    p "Ошибка: #{e.message}"
    train_menu
  end

  def train_remove_car
    train = train_choice
    if train.cars.size >= 1
      train.remove_car(train.cars.last)
      p "У поезда № #{train.number} отцеплен вагон."
    else
      p 'В поезде не осталось вагонов!'
    end
  end

  def train_load
    train = train_choice
    train_cars_list(train)
    p 'Для выбора необходимого вагона'
    car = train.cars[id_user_prompt(train.cars.size)]
    if train.type == 'Cargo'
      p 'Введите объем груза: '
      car.load(gets.chomp.to_f)
      p 'Погрузка прошла успешно!'
    elsif train.type == 'Passenger'
      car.take_seats
      p 'Занято 1 свободное место'
    end
  rescue RuntimeError => e
    p "Ошибка: #{e.message}"
    train_menu
  end

  def train_move_next
    train = train_choice
    if train.route.nil?
      p "Поезду № #{train.number} еще не назначен маршрут."
    elsif train.current_station == train.route.stations.last
      p "Поезд № #{train.number} уже прибыл на конечную станцию"
    else
      train.move_next_station
      p "Поезд № #{train.number} прибыл на #{train.current_station.name}"
    end
  end

  def train_move_previous
    train = train_choice
    if train.route.nil?
      p "Поезду № #{train.number} еще не назначен маршрут."
    elsif train.current_station == train.route.stations.first
      p "Поезд № #{train.number} уже прибыл на начальную станцию"
    else
      train.move_previous_station
      p "Поезд № #{train.number} прибыл на #{train.current_station.name}"
    end
  end

  def error_message
    p 'Неверная комманда, введите корректный номер операции!'
  end
end
