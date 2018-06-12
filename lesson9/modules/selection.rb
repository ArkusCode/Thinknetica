module SelectionUI
  protected

  def train_cars_list(train)
    num = 0
    train.iterate_cars do |c|
      p "#{num += 1}: #{c.type} Свободно: #{c.free} Занято: #{c.filled}"
    end
  rescue RuntimeError => e
    p "Ошибка: #{e.message}"
    train_menu
  end

  def station_trains_list
    station = station_choice
    station.iterate_trains do |t|
      p "#{t.number} - #{t.type}, Кол-во вагонов: #{t.cars.size}"
    end
  rescue RuntimeError => e
    p "Ошибка: #{e.message}"
    info_menu
  end

  def stations_list
    if @stations.empty?
      p 'Еще не создано ни одной станции, пора создать!'
      create_menu
    else
      @stations.each.with_index(1) do |st, index|
        p "#{index}: #{st.name}"
      end
    end
  end

  def trains_list
    if @trains.empty?
      p 'Еще не создано ни одного поезда, пора создать'
      create_menu
    else
      @trains.each.with_index(1) do |train, index|
        p "#{index}: #{train.number} - #{train.type}"
      end
    end
  end

  def routs_list
    if @routs.empty?
      p 'Еще не создано ни одного маршрута, пора создать!'
      route_menu
    else
      @routs.each.with_index(1) do |r, i|
        p "#{i}: #{r.stations.first.name} - #{r.stations.last.name}"
      end
    end
  end

  def id_user_prompt(size)
    @size = size
    p 'Выберите порядковый номер из списка вверху: '
    loop do
      @choice_id = gets.chomp.to_i
      break if @choice_id.between?(1, @size)
      p "Неверный номер, выберите номер от 1 до #{@size}"
    end
    @choice_id -= 1
  end

  def train_choice
    trains_list
    p 'Для выбора необходимого поезда'
    @train_choice = @trains[id_user_prompt(@trains.size)]
  end

  def route_choice
    routs_list
    p 'Для выбора необходимого маршрута'
    @route_choice = @routs[id_user_prompt(@routs.size)]
  end

  def station_choice
    stations_list
    p 'Для выбора необходимой станции'
    @station_choice = @stations[id_user_prompt(@stations.size)]
  end
end
