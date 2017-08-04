require 'spec_helper'
require 'byebug'

class FirstStep < Forminator::Step
  validations do
    required(:email) { filled? }
    required(:name) { filled? }
  end

  def persist?
    true
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
      expect(subject.call(params)).to eq [true, params]
    end

    it 'return the validity and initial params if not valid' do
      expect(subject.call(invalid_params)).to eq [false, invalid_params]
    end
  end

  describe "#valid?" do
    it 'returns true - the params are valid' do
      expect(subject.new(params).valid?).to be true
    end

    it 'returns false - the params are not valid' do
      expect(subject.new(invalid_params).valid?).to be false
    end
  end

  describe "#persist?" do
    it 'returns true - persists the object' do
      expect(subject.new(params).persist?).to be true
    end

    it 'returns false - does not persist the object' do
      subject.class_eval { def persist?; false; end; }

      expect(subject.new(params).persist?).to be false
    end
  end
end
