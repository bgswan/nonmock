class CommandParser
  END_SALE_COMMAND = 'EndSale'
  START_SALE_COMMAND = 'NewSale'
  INPUT = 'Input'
  
  def initialize( sale_event_listener )
    @sale_event_listener = sale_event_listener
  end
  
  def parse( command )
    command_type, command_body = command.split(':')
    if INPUT == command_type.strip
      process_input_command( command_body.strip )
    else
      process_command( command_body.strip )
    end
  end
  
private  
  def process_input_command( command_body )
    arguments = {}
    command_args = command_body.split(',')
    command_args.each do |argument|
      arg_name, arg_value = argument.split('=')
      arguments[arg_name.strip] = arg_value.strip
    end
    
    @sale_event_listener.item_entered( ItemId.new( arguments['Barcode'] ), Quantity.new( arguments['Quantity'].to_i ) )
  end
  
  def process_command( command )
    if END_SALE_COMMAND == command
      @sale_event_listener.sale_completed
    elsif START_SALE_COMMAND == command
      @sale_event_listener.new_sale_initiated
    end
  end
end