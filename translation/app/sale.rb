class Sale
  
  def initialize()
    @items_purchased = []
  end
  
  def send_receipt_to(receipt_receiver)
    total = @items_purchased.inject(Money.new(0.00)) do |total, item|
      total += item.price
    end
    receipt_receiver.print_total_due( total )
  end
  
  def purchase_item_with(product_description)
    @items_purchased << product_description
  end
end