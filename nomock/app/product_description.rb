class ProductDescription
  
  attr_reader :price
  
  def initialize(attributes)
    @price = attributes[:price]
  end
  
end