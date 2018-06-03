class Route

  include InstanceCounter

  attr_accessor :stations, :from, :to

  def initialize(from, to)
  @stations = [from, to]
    puts "Создан маршрут #{stations.first.name} - #{stations.last.name}"
  register_instance
  end

  def add(station)
    self.stations.insert(-2, station)
  end

  def remove(station)
    if self.stations.first == station || self.stations.last == station
      puts "Вы не можете удалить начальную или конечную станцию маршрута!"
    elsif !stations.any? { |s| s == station } || station == ''
      puts "Станция не удалена: имя не может быть пустым, либо такой станции нет в маршруте."
    else
      self.stations.delete(station)
      puts "Из текущего маршрута убрана станция #{station.name}"
    end
  end

  def show_route
    stations.each.with_index(1) do |st, index|
      puts "#{index}: #{st.name}"
    end
  end
end
