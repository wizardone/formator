require 'spec_helper'

RSpec.describe Forminator::Flow do

  let(:steps) { [FirstStep, SecondStep] }

  describe '#initialize' do
    it 'initializes the flow with steps' do
      flow = described_class.new(steps: steps)

      expect(flow.steps).to match_array steps
    end
  end

  describe '#current_step' do
    it 'returns the current step in the flow' do
      flow = described_class.new(steps: steps)

      expect(flow.current_step).to eq steps.first
    end
  end

  describe '#next_step' do
    it 'returns the next step in the flow' do
      flow = described_class.new(steps: steps)

      expect(flow.next_step).to eq steps.last
    end
  end

  describe '#previous_step' do
    it 'returns the previous step in the flow' do
      flow = described_class.new(steps: steps)

      expect(flow.next_step).to eq steps.last
    end
  end

  describe '#add' do
    it 'adds another step' do
      flow = described_class.new(steps: steps)
      flow.add(step: ThirdStep)

      expect(flow.steps).to include(ThirdStep)
    end

    it 'does not add another step if the step is not a subclass of forminator' do
      flow = described_class.new(steps: steps)

      expect {
        flow.add(step: BogusStep)
      }.to raise_error(Forminator::InvalidStep)
    end
  end

  describe '#remove' do
    it 'removes a step from the steps array' do
      flow = described_class.new(steps: steps)
      flow.remove(step: SecondStep)

      expect(flow.steps).to_not include(SecondStep)
      expect(flow.steps).to match_array([FirstStep])
    end
  end
end
