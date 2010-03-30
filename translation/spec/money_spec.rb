require File.dirname(__FILE__) + '/../app/money'

describe Money do
  
  it "should be equal on value" do
    first = Money.new(3.00)
    
    first.should == Money.new(3.00)
  end
  
  it "should add two monies" do
    first = Money.new(3.00)
    second = Money.new(7.00)
    
    total = first + second
    total.should == Money.new(10.00)
  end
end
