class Station

  include InstanceCounter

  attr_reader :name, :trains
  @@stations_all = []
  
  def self.all
    @@stations_all
  end

  def initialize(name)
    @name = name
    @trains = []
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
     
end
