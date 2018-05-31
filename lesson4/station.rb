class Station

  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = [] 
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
