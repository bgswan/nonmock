require 'spec/test/unit'
Dir[File.dirname(__FILE__) + '/../app/*.rb'].each {|file| require file }

module Builders
  
  def a_product(attributes)
    ProductDescription.new(attributes)
  end
  
  def gbp(amount)
    Money.new(amount)
  end
end

describe Register do
  
  include Builders
  
  before(:each) do
    @printer = StringIO.new
    @product_catalog = ProductCatalog.new
    @register = Register.new(@product_catalog, @printer)
  end

  it "should not calculate a receipt when there is no sale" do
    @register.handle_command("Command:EndSale")
    
    assert_equal "", @printer.string
  end
  
  it "should calculate a zero receipt for a sale with no items" do
    @register.handle_command("Command:NewSale")
    @register.handle_command("Command:EndSale")
    
    assert_equal "0.00", @printer.string
  end
  
  it "should calculate receipt for sale with multiple items of single quantity" do
    @product_catalog.stub(:lookup).and_return( a_product(:price => gbp(3.00)), a_product(:price => gbp(7.00)) )
    
    @register.handle_command("Command:NewSale")
    @register.handle_command("Input: Barcode=100000000001, Quantity =1")
    @register.handle_command("Input: Barcode=100000000002, Quantity =1")
    @register.handle_command("Command:EndSale")

    assert_equal "10.00", @printer.string
  end
end