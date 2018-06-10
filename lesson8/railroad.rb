class RailRoad
  include RailRoadUI

  def initialize
    @stations = []
    @trains = []
    @routs = []
  end

  def run
    puts 'Вас приветствует RailRoad Manager v0.2a!'
    main_menu
  end

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity

  def main_menu
    puts %(
    Для выполнения необходимой операции введите ее номер.
    0 : Выход
    1 : Создать (станцию, поезд)
    2 : Управление маршрутами (создание новых маршрутов,
        добавление/удаление промежуточных станций)
    3 : Управление существующими поездами (назначение маршрута,
        добавление/удаление вагонов, передвижение по маршруту)
    4 : Информация (список станций/список поездов на станции)
    )
    print 'Введите номер операции: '
    choice = gets.chomp.to_i
    case choice
    when 0
      puts 'Работа завершена, спасибо за использование нашей программы!'
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
    end
    main_menu
  end

  protected

  def create_menu
    puts %(
    0 : Вернуться в главное меню
    1 : Создать станцию
    2 : Создать поезд
    )
    print 'Введите номер операции: '
    choice = gets.chomp.to_i
    case choice

    when 0
      main_menu

    when 1
      station_create

    when 2
      train_create

    else
      error_message

    end
    create_menu
  end

  def route_menu
    puts %(
    0 : Вернуться в главное меню
    1 : Создать новый маршрут
    2 : Добавить промежуточную станцию в уже существующий маршрут
    3 : Удалить промежуточную станцию из уже существующего маршрута
    4 : Список маршрутов со всеми остановками
    )
    print 'Введите номер операции: '
    choice = gets.chomp.to_i
    case choice
    when 0
      main_menu

    when 1
      create_route

    when 2
      add_to_route

    when 3
      delete_from_route

    when 4
      show_all_route

    else
      error_message

    end
    route_menu
  end

  def train_menu
    puts %(
    0 : Вернуться в главное меню
    1 : Назначить поезду новый маршрут
    2 : Прицепить поезду новый вагон
    3 : Отцепить вагон от поезда
    4 : Занять место/объем в вагоне поезда
    5 : Список всех вагонов поезда
    6 : Переместить поезд на 1 станцию вперед по маршруту
    7 : Переместить поезд на 1 станцию назад по маршруту
    )
    print 'Введите номер операции: '
    choice = gets.chomp.to_i
    case choice
    when 0
      main_menu

    when 1
      train_set_route

    when 2
      train_add_car

    when 3
      train_remove_car

    when 4
      train_load

    when 5
      train_cars_list(train_choice)

    when 6
      train_move_next

    when 7
      train_move_previous

    else
      error_message

    end
    train_menu
  end

  def info_menu
    puts %(
    0 : Вернуться в главное меню
    1 : Список всех станций
    2 : Список всех поездов на конкретной станции
    )
    print 'Введите номер операции: '
    choice = gets.chomp.to_i
    case choice
    when 0
      main_menu

    when 1
      stations_list

    when 2
      station_trains_list

    else
      error_message
    end
    info_menu
  end
end

# rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity
