require 'spec_helper'
require 'byebug'

class FirstStep < Forminator::Step
  validations do
    required(:email) { filled? }
    required(:name) { filled? }
  end
end

RSpec.describe Forminator do
  it 'has a version number' do
    expect(Forminator::VERSION).not_to be nil
  end
end

RSpec.describe Forminator::Step do
  subject { FirstStep }
  let(:params) { { email: 'test@test.com', name: 'Test' } }
  let(:invalid_params) { { email: 'test@test.com' } }

  describe '.call' do
    #before do
    #  step = instance_double(Forminator::Step, valid?: true)
    #  expect(described_class).to receive(:new).with(params) { step }
    #  expect(step).to receive(:valid?)
    #end

    it 'initializes a step and validates it' do
      step = instance_double(Forminator::Step, valid?: true)
      expect(described_class).to receive(:new).with(params) { step }
      expect(step).to receive(:valid?)

      described_class.call(params)
    end

    it 'return the validity and initial params if valid' do
      step = instance_double(Forminator::Step, valid?: true)
      expect(described_class).to receive(:new).with(params) { step }
      expect(step).to receive(:valid?)

      expect(subject.call(params)).to eq [true, params]
    end

    it 'return the validity and initial params if not valid' do
      step = instance_double(Forminator::Step, valid?: false)
      expect(described_class).to receive(:new).with(invalid_params) { step }
      expect(step).to receive(:valid?)

      expect(subject.call(invalid_params)).to eq [false, invalid_params]
    end
  end

  describe "#valid?" do
    it 'validates the params' do
      dry_result = double('Dry::Validations::Result')
      expect_any_instance_of(::Hanami::Validations).to receive(:validate) { dry_result }
      expect(dry_result).to receive(:success?)

      subject.new(params).valid?
    end
  end
end
