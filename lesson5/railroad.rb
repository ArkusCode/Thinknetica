class RailRoad

  def initialize
    @stations = []
    @trains = []
    @routs = []
  end

  def run
    puts "Вас приветствует RailRoad Manager v0.1a!"
    main_menu
  end

  def main_menu
    puts %Q(
    Для выполнения необходимой операции введите ее номер.
    0 : Выход
    1 : Создать (станцию, поезд, вагон)
    2 : Управление маршрутами (создание новых маршрутов, 
        добавление/удаление промежуточных станций)
    3 : Управление существующими поездами (назначение маршрута, 
        добавление/удаление вагонов, передвижение по маршруту)
    4 : Информация (список станций/список поездов на станции)
    )
    print "Введите номер операции: "
    choice = gets.chomp.to_i
    case choice
    when 0
      puts "Работа завершена, спасибо за использование нашей программы!"
      exit

    when 1
      create_menu

    when 2
      route_menu

    when 3
      train_menu

    when 4
      info_menu

    else
      error_message
      main_menu
    end  
  end

private #Не должно быть доступно извне класса

CAR_TYPES = { 'Cargo' => CargoCar, 'Passenger' => PassengerCar }
  
  def create_menu
    puts %Q(
    0 : Вернуться в главное меню
    1 : Создать станцию
    2 : Создать поезд
    )
    print "Введите номер операции: "
    choice = gets.chomp.to_i
    case choice

    when 0
      main_menu

    when 1
      puts "Введите название новой станции"
      station_name = gets.chomp
      unless @stations.any? { |s| s.name == station_name } || station_name.empty?
        @stations << Station.new(station_name)
      else
        puts "Станция не создана: название не может быть пустым, либо такая станция уже создана."
      end

    when 2
      puts "Введите номер поезда"
      number = gets.chomp
      unless @trains.any? { |t| t.number == number } || number.empty?
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
      else
        puts "Поезд не создан: номер не может быть пустым, либо такой поезд уже создан."
      end  

    else
      error_message
    end
    create_menu  
  end

  def route_menu
    puts %Q(
    0 : Вернуться в главное меню
    1 : Создать новый маршрут
    2 : Добавить промежуточную станцию в уже существующий маршрут
    3 : Удалить промежуточную станцию из уже существующего маршрута
    4 : Список маршрутов со всеми остановками
    )
    print "Введите номер операции: "
    choice = gets.chomp.to_i
    case choice
    when 0
      main_menu

    when 1
      if @stations.size < 2 
        puts "Сначала создайте хотя бы пару станций"
      else
        stations_list
        puts "Введите номер начальной станции маршрута: "
        first_station = @stations[id_user_prompt(@stations.size)]
        puts "Введите номер конечной станции маршрута: "
        end_station = @stations[id_user_prompt(@stations.size)]
        @routs << Route.new(first_station, end_station)
      end

    when 2
      route = route_choice
      station = station_choice
      route.add(station)
      puts "Добавленна промежуточная остановка на станции #{station.name}"
      
    when 3
      route = route_choice
      puts "В маршрут #{route.stations.first.name} - #{route.stations.last.name} входят: "
      route.show_route
      station = route.stations[id_user_prompt(route.stations.size)]
      route.remove(station)

    when 4
      @routs.each do |route|
        puts "В маршрут #{route.stations.first.name} - #{route.stations.last.name} входят: "
        puts route.show_route
      end

    else
      error_message
    end
    route_menu  
  end

  def train_menu
    puts %Q(
    0 : Вернуться в главное меню
    1 : Назначить поезду новый маршрут
    2 : Прицепить поезду новый вагон
    3 : Отцепить вагон от поезда
    4 : Переместить поезд на 1 станцию вперед по маршруту
    5 : Переместить поезд на 1 станцию назад по маршруту
    )
    print "Введите номер операции: "
    choice = gets.chomp.to_i
    case choice
    when 0
      main_menu

    when 1
      train = train_choice
      route = route_choice
      train.set_route(route)
      puts "Поезду № #{train.number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}."

    when 2
      train = train_choice
      train.add_car(CAR_TYPES[train.type].new)

    when 3
      train = train_choice
      train.remove_car(train.cars.last)

    when 4
      train_choice.move_next_station

    when 5
      train_choice.move_previous_station

    else
      error_message
    end
    train_menu  
  end

  def info_menu
    puts %Q(
    0 : Вернуться в главное меню
    1 : Список всех станций
    2 : Список всех поездов на конкретной станции
    )
    print "Введите номер операции: "
    choice = gets.chomp.to_i
    case choice
    when 0
      main_menu

    when 1
      stations_list

    when 2
      station_choice.list
       
    else
      error_message
    end
    info_menu 
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
