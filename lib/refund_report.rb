require_relative './abstract_calculation.rb'

class RefundReport
  DEFAULT_CALCULATION_RULES = {
    'TRANSPORTATION' => AbstractCalculation.new(max: 100, regular: 0.12, extra: 0.08),
    'MEAL' => AbstractCalculation.new(max: 3, regular: 10, extra: 6),
    'PARKING' => AbstractCalculation.new(max: 20, regular: 1, extra: 0.5)
  }
  
  def initialize(lines = [], calculation_rules: DEFAULT_CALCULATION_RULES)
    @lines = lines
    @calculation_rules = calculation_rules
  end

  def errors?
    !@lines.is_a?(Array)
  end

  def total_concept(concept)
    amount_by_concept[concept]
  end

  def total_refund
    amount_by_concept.values.sum
  end

  private

  def amount_by_concept
    units_by_concept.map do |concept, units|
      [concept, calculator_for(concept).calculate_refund(units)]
    end.to_h
  end

  def units_by_concept
    @lines
      .group_by { |l| l[:key] }
      .transform_values do |lines|
        lines.sum { |l| l[:units] }
      end
  end

  def calculator_for(concept)
    @calculation_rules[concept]
  end
end