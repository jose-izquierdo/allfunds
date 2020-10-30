class AbstractCalculation
  def initialize(quantity, max, regular, extra)
    @quantity = quantity
    @max = max
    @regular = regular
    @extra = extra
  end
  
  def calculate_refund
    if @quantity > @max
      calculate_excess
    else
      return @quantity * @regular
    end
  end
  
  def calculate_excess
    excess = @quantity - @max
    total = (@max * @regular) + (excess * @extra)
    
    return total
  end
end