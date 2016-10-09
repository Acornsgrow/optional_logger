require 'spec_helper'

RSpec.describe OptionalLogger::Logger do
  describe '.new' do
    subject { described_class }

    it 'constructs an instance of the optional logger' do
      optional_logger = subject.new(double)
      expect(optional_logger).to be_a(OptionalLogger::Logger)
    end

    it 'stores the provided logger in an instance variable' do
      logger = double
      optional_logger = subject.new(logger)
      expect(optional_logger.instance_variable_get(:@logger)).to eq(logger)
    end
  end
end
