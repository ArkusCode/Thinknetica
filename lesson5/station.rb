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
    puts "На станцию #{@name} прибыл поезд № #{train.number}."
  end

  def list
    @trains.each {|train| puts "Поезд № #{train.number}, тип: #{train.type}."}
  end

  def send_train(train)
    @trains.delete(train)
    puts "Со станции #{@name} отправился поезд № #{train.number}."
  end
     
end
