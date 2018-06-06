class Station

  include InstanceCounter
  include Valid

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

  def list
    @trains
  end

  def send_train(train)
    @trains.delete(train)
  end

  def validate!
    raise "Станция с таким названием уже создана!" if Station.all.any? { |s| s.name == name }
    raise "Название не может быть пустым!" if name.empty?
    true
  end
end
