require 'spec_helper'

RSpec.describe Forminator do
  it 'has a version number' do
    expect(Forminator::VERSION).not_to be nil
  end
end

RSpec.describe Forminator::Step do
  let(:params) { { email: 'test@test.com', name: 'Test' } }

  describe '.call' do
    it 'initializes a step and validates it' do
      step = instance_double(Forminator::Step, validate: true)
      expect(described_class).to receive(:new).with(params) { step }
      expect(step).to receive(:validate)

      described_class.call(params)
    end
  end

  describe '#initialize' do
    it 'initializes the params' do
      step = described_class.new(params)

      expect(step.params).to eq params
    end
  end
end
