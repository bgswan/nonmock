require File.dirname(__FILE__) + '/../app/command_parser'
require File.dirname(__FILE__) + '/../app/quantity'
require File.dirname(__FILE__) + '/../app/item_id'

describe CommandParser do
  
  before(:each) do
    @sale_event_listener = mock(:sale_event_listener)
    @command_parser = CommandParser.new( @sale_event_listener )
  end
  
  it "should notify listener of new sale event" do
    new_sale_command = "Command:NewSale"
    
    @sale_event_listener.should_receive(:new_sale_initiated).once
    
    @command_parser.parse( new_sale_command )
  end
  
  it "should notify listener of sale completed event" do
    new_sale_command = "Command:EndSale"
    
    @sale_event_listener.should_receive(:sale_completed).once
    
    @command_parser.parse( new_sale_command )
  end
  
  it "should notify listener of item and quantity entered" do
    message = "Input: Barcode=100008888559, Quantity =1"
    expected_item_id = ItemId.new('100008888559')
    expected_quantity = Quantity.new(1)
    
    @sale_event_listener.should_receive(:item_entered).with( expected_item_id, expected_quantity ).once
    
    @command_parser.parse( message )
  end
end