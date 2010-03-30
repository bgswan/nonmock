class ItemId
  
  attr_reader :barcode
  
  def initialize(barcode)
    @barcode = barcode
  end
  
  def eql?(object)
    self == object
  end
  
  def ==(object)
    object.equal?(self) ||
    object.instance_of?(self.class) && object.barcode == barcode
  end
end