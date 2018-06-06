module RailRoadUI

protected
CAR_TYPES = { 'Cargo' => CargoCar, 'Passenger' => PassengerCar }

  def station_create
    puts "Введите название новой станции"
    station_name = gets.chomp
    unless @stations.any? { |s| s.name == station_name } || station_name.empty?
      @stations << Station.new(station_name)
    else
      puts "Станция не создана: название не может быть пустым, либо такая станция уже создана."
    end
  end

  def train_create
    puts "Введите номер поезда в формате ХХХХХ или ХХХ-ХХ"
    number = gets.chomp.to_s
    puts "Для создания пассажирского поезда введите '1', для грузового '2'."
    type_choice = gets.chomp.to_i
    case type_choice
    when 1
      @trains << PassengerTrain.new(number)
    when 2
      @trains << CargoTrain.new(number)
    else
      puts "Поезд не создан: неверная комманда."
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    if @stations.size < 2 
        puts "Сначала создайте хотя бы пару станций"
    else
      stations_list
      puts "Введите номер начальной станции маршрута: "
      first_station = @stations[id_user_prompt(@stations.size)]
      puts "Введите номер конечной станции маршрута: "
      end_station = @stations[id_user_prompt(@stations.size)]
      @routs << Route.new(first_station, end_station)
      puts "Создан маршрут #{first_station.name} - #{end_station.name}"
    end
  end

  def add_to_route
    route = route_choice
    station = station_choice
    route.add(station)
    puts "Добавленна промежуточная остановка на станции #{station.name}"
  end

  def delete_from_route
    route = route_choice
    puts "В маршрут #{route.stations.first.name} - #{route.stations.last.name} входят: "
    route.show_route.each.with_index(1) {|st, index| puts "#{index}: #{st.name}"}
    station = route.stations[id_user_prompt(route.stations.size)]
    if route.stations.first == station || route.stations.last == station
      puts "Вы не можете удалить начальную или конечную станцию маршрута!"
    else
      route.remove(station)
      puts "Из текущего маршрута убрана станция #{station.name}"
    end
  end

  def show_all_route
    @routs.each do |route|
      puts "В маршрут #{route.stations.first.name} - #{route.stations.last.name} входят: "
      puts route.show_route.each.with_index(1) {|st, index| puts "#{index}: #{st.name}"}
    end
  end

  def train_set_route
    train = train_choice
    route = route_choice
    train.set_route(route)
    puts "Поезду № #{train.number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}."
  end

  def train_add_car
    train = train_choice
    train.add_car(CAR_TYPES[train.type].new)
    puts "Поезду № #{train.number} прицеплен вагон."
  end

  def train_remove_car
    train = train_choice
    if train.cars.size >= 1
      train.remove_car(train.cars.last)
      puts "У поезда № #{train.number} отцеплен вагон." 
    else
      puts "В поезде не осталось вагонов!"
    end
  end

  def train_move_next
    train = train_choice
    if train.route.nil?
      puts "Поезду № #{train.number} еще не назначен маршрут."
    elsif train.current_station == train.route.stations.last
      puts "Поезд № #{train.number} уже прибыл на конечную станцию маршрута #{train.current_station.name}"
    else
      train.move_next_station
      puts "Поезд № #{train.number} прибыл на станцию #{train.current_station.name}"
    end
  end

  def train_move_previous
    train = train_choice
    if train.route.nil?
      puts "Поезду № #{train.number} еще не назначен маршрут."
    elsif train.current_station == train.route.stations.first
      puts "Поезд № #{train.number} уже прибыл на конечную станцию маршрута #{train.current_station.name}"
    else
      train.move_previous_station
      puts "Поезд № #{train.number} прибыл на станцию #{train.current_station.name}"
    end
  end

  def stations_list
    if @stations.empty?
      puts "Еще не создано ни одной станции, пора создать!"
      create_menu
    else
      @stations.each.with_index(1) do |st, index|
        puts "#{index}: #{st.name}"
      end
    end
  end

  def trains_list
    if @trains.empty?
      puts "Еще не создано ни одного поезда, пора создать"
      create_menu
    else
      @trains.each.with_index(1) do |train, index|
        puts "#{index}: #{train.number} - #{train.type}"
      end
    end
  end

  def routs_list
    if @routs.empty?
      puts "Еще не создано ни одного маршрута, пора создать!"
      route_menu
    else
      @routs.each.with_index(1) do |route, index|
        puts "#{index}: #{route.stations.first.name} - #{route.stations.last.name}"
      end
    end
  end

  def id_user_prompt(size)
    @size = size
    puts "Выберите порядковый номер из списка вверху: "
    loop do
      @choice_id = gets.chomp.to_i
      break if @choice_id.between?(1, @size)   
      puts "Неверный номер, выберите номер от 1 до #{@size}"
    end
    @choice_id -= 1
  end

  def train_choice
    trains_list
    puts "Для выбора необходимого поезда"
    @train_choice = @trains[id_user_prompt(@trains.size)]
    @train_choice
  end

  def route_choice
    routs_list
    puts "Для выбора необходимого маршрута"
    @route_choice = @routs[id_user_prompt(@routs.size)]
    @route_choice
  end

  def station_choice
    stations_list
    puts "Для выбора необходимой станции"
    @station_choice = @stations[id_user_prompt(@stations.size)]
    @station_choice
  end

  def error_message
    puts "Неверная комманда, введите корректный номер операции!"
  end
end
