class CargoCar < Car
  attr_reader :filled, :type

  def initialize(capacity)
    @capacity = capacity
    @type = 'Cargo'
    @filled = 0
  end

  def load(volume)
    raise 'Свободное место закончилось!' if @filled + volume > @capacity
    @filled += volume
  end

  def free
    @capacity - @filled
  end
end
