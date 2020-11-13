require_relative '../lib/refund_report'

RSpec.describe RefundReport do
  let(:refund_report) { described_class.new(lines) }

  context "for invalid data" do
    let(:lines) { 'invalid data' }
    
    it 'must have errors' do
      expect(refund_report.errors?).to be_truthy
    end
  end
  
  context 'for valid report 1' do
    let(:lines) { [
      { key: 'TRANSPORTATION', units: 75} , 
      { key: 'MEAL', units: 1 },
      { key: 'TRANSPORTATION', units: 45 },
      { key: 'MEAL', units: 1 },
      { key: 'TRANSPORTATION', units: 35 },
      { key: 'MEAL', units: 1 },
      { key: 'MEAL', units: 1 },
      { key: 'PARKING', units: 35 },
      { key: 'TRANSPORTATION', units: 20 },
      { key: 'MEAL', units: 1 },
      { key: 'PARKING', units: 10 }
    ] }

    it 'must not have errors' do
      expect(refund_report.errors?).to be_falsy
    end

    it 'must return a total of transportation refund of 18$' do
      expect(refund_report.total_concept('TRANSPORTATION')).to match(18)
    end

    it 'must return a total of meal refund of 42$' do
      expect(refund_report.total_concept('MEAL')).to match(42)
    end

    it 'must return a total of parking refund of 32.5$' do
      expect(refund_report.total_concept('PARKING')).to match(32.5)
    end

    it 'must return 92.5$ of total refund' do
      expect(refund_report.total_refund).to match(92.5)
    end
  end

  context 'for valid report 2' do
    let(:lines) { [
      { key: 'TRANSPORTATION', units: 75 }, 
      { key: 'MEAL', units: 1 },
      { key: 'TRANSPORTATION', units: 15 },
      { key: 'MEAL', units: 1 },
      { key: 'MEAL', units: 1 },
      { key: 'PARKING', units: 15 },
      { key: 'TRANSPORTATION', units: 20 },
      { key: 'MEAL', units: 1 },
      { key: 'PARKING', units: 20 }
    ] }

    it 'must not have errors' do
      expect(refund_report.errors?).to be_falsy
    end

    it 'must return a total of transportation refund of 12.8$' do
      expect(refund_report.total_concept('TRANSPORTATION')).to match(12.8)
    end

    it 'must return a total of meal refund of 36$' do
      expect(refund_report.total_concept('MEAL')).to match(36)
    end

    it 'must return a total of parking refund of 27.5$' do
      expect(refund_report.total_concept('PARKING')).to match(27.5)
    end

    it 'must return 76.3$ of total refund' do
      expect(refund_report.total_refund).to match(76.3)
    end
  end
end