class AbstractCalculation
  def initialize(max:, regular:, extra:)
    @max = max
    @regular = regular
    @extra = extra
  end
  
  def calculate_refund(quantity)
    return calculate_excess(quantity) if quantity > @max
    quantity * @regular
  end

  private

  def calculate_excess(quantity)
    excess = quantity - @max
    (@max * @regular) + (excess * @extra)
  end
end