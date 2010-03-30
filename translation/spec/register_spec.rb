Dir[File.dirname(__FILE__) + '/../app/*.rb'].each {|file| require file }

describe Register do
  
  before(:all) do
    @item_id_1 = ItemId.new('000000001')
    @item_id_2 = ItemId.new('000000002')
    @description_for_item_id_1 = ProductDescription.new('description 1', Money.new(3.00))
    @description_for_item_id_2 = ProductDescription.new('description 2', Money.new(7.00))
    @single_item = Quantity.new(1)
  end
  
  before(:each) do
    @receipt_printer = mock(:receipt_printer)
    @product_catalog = mock(:product_catalog)
    @product_catalog.stub(:product_description_for).and_return(@description_for_item_id_1, @description_for_item_id_2)
    @register = Register.new(@receipt_printer, @product_catalog)
  end
  
  it "should have a receipt total of zero for a sale with no items" do
    @register.new_sale_initiated
    
    total_due = Money.new(0.00)
    @receipt_printer.should_receive(:print_total_due).with(total_due).once
    
    @register.sale_completed
  end
  
  it "should not calculate receipt when there is no sale" do
    @receipt_printer.should_receive(:print_total_due).never
    
    @register.sale_completed
  end
  
  it "should calculate receipt for sale with multiple items of single quantity" do
    @register.new_sale_initiated
    @register.item_entered(@item_id_1, @single_item)
    @register.item_entered(@item_id_2, @single_item)
    
    @receipt_printer.should_receive(:print_total_due).with(Money.new(10.00)).once()
    
    @register.sale_completed
  end
end
