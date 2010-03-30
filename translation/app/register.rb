require File.dirname(__FILE__) + '/sale'

class Register
  
  def initialize(printer, product_catalog)
    @printer = printer
    @product_catalog = product_catalog
  end
  
  def new_sale_initiated
    @sale = Sale.new
  end
  
  def item_entered(item_id, quantity)
    product_description = @product_catalog.product_description_for(item_id)
    @sale.purchase_item_with(product_description)
  end
  
  def sale_completed
    @sale.send_receipt_to(@printer) unless @sale.nil?
  end
end