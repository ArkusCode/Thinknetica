class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains
  @@stations_all = []
  NAME_FORMAT = /^[a-zа-я0-9]+$/i

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

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
end
