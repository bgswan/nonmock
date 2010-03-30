class Quantity
  
  attr_reader :value
  
  def initialize(value)
    @value = value
  end
  
  def eql?(object)
    self == object
  end
  
  def ==(object)
    object.equal?(self) ||
    object.instance_of?(self.class) && object.value == value
  end
end