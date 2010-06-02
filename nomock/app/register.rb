class Register
  
  def initialize(product_catalog, printer)
    @printer = printer
    @product_catalog = product_catalog
  end
  
  def handle_command(command)
    case command
    when /Command:NewSale/
      @item_prices = []
    when /^Input:.*Barcode=(.*),.Quantity.=(.*)/
      add_item($1, $2)
    when /Command:EndSale/
      print_receipt(@printer, @item_prices)
    end
  end
  
private
  def add_item(barcode, quantity)
    product_description = @product_catalog.lookup(barcode)
    @item_prices << product_description.price
  end
  
  def print_receipt(printer, item_prices)
    return if item_prices.nil?
    
    total = item_prices.inject(Money.new(0.00)) {|total, price| total += price}
    printer.print total
  end
end