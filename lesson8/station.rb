class Station
  include InstanceCounter
  include Validate

  attr_reader :name, :trains
  @@stations_all = []

  def self.all
    @@stations_all
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations_all << self
    register_instance
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def iterate_trains
    raise 'На этой станции нет поздов!' if @trains.empty?
    @trains.each { |train| yield(train) }
  end

  def validate!
    raise 'Станция уже создана!' if Station.all.any? { |s| s.name == name }
    raise 'Название не может быть пустым!' if name.empty?
    true
  end
end
