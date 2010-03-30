class Money
  
  attr_reader :amount
  
  def initialize(amount)
    @amount = amount
  end
  
  def +(other)
    Money.new( amount + other.amount )
  end
  
  def eql?(object)
    self == object
  end
  
  def ==(object)
    object.equal?(self) ||
    object.instance_of?(self.class) && object.amount == amount
  end
end