require_relative './abstract_calculation.rb'

class RefundReport
  MAX_KM = 100
  REGULAR_KM_RATE = 0.12
  EXCESS_KM_RATE = 0.08
  MAX_MEALS = 3
  REGULAR_MEALS_REFUND = 10
  EXCESS_MEALS_REFUND = 6
  MAX_PARKING = 20
  REGULAR_PARKING_REFUND = 1
  EXCESS_PARKING_REFUND = 0.5
  
  def initialize(refunds)
    @errors = false
    @refunds = refunds 
    @transportation = 0
    @meal = 0
    @parking = 0
    @total_transportation = 0
    @total_meal = 0
    @total_parking = 0
    @total_refund = 0
    
    valid_data? ? operate : (@errors = true)
  end

  def errors?
    @errors
  end

  def total_transportation
    @total_transportation
  end

  def total_meal
    @total_meal
  end

  def total_parking
    @total_parking
  end

  def total_refund
    @total_refund
  end

  private
    
    def valid_data?
      return @refunds.is_a?(Array)
    end
    
    def operate
      @refunds.each do |refund|
        @transportation += refund[:units] if refund[:key] == 'TRANSPORTATION'
        @meal += refund[:units] if refund[:key] == 'MEAL'
        @parking += refund[:units] if refund[:key] == 'PARKING'
      end
      
      calculate_refund unless @transportation == 0 && @meal == 0 && @parking == 0  
    end

    def calculate_refund
      @total_transportation = AbstractCalculation.new(@transportation, MAX_KM, REGULAR_KM_RATE, EXCESS_KM_RATE).calculate_refund
      @total_meal = AbstractCalculation.new(@meal, MAX_MEALS, REGULAR_MEALS_REFUND, EXCESS_MEALS_REFUND).calculate_refund
      @total_parking = AbstractCalculation.new(@parking, MAX_PARKING, REGULAR_PARKING_REFUND, EXCESS_PARKING_REFUND).calculate_refund

      @total_refund = @total_transportation + @total_meal + @total_parking
    end
end