require 'spec_helper'

RSpec.describe OptionalLogger::LoggerManagement do
  describe '.logger' do
    context 'when given a logger' do
      context 'when the logger has NOT previously been set' do
        it 'wraps given logger in an optional logger' do
          klass = Class.new do
            include OptionalLogger::LoggerManagement
          end

          logger = double('logger')
          expect(OptionalLogger::Logger).to receive(:new).with(logger)
          klass.logger(logger)
        end

        it 'stores the optional logger' do
          klass = Class.new do
            include OptionalLogger::LoggerManagement
          end

          logger = double('logger')
          optional_logger = double('optional_logger')
          allow(OptionalLogger::Logger).to receive(:new).with(logger).and_return(optional_logger)
          rv = klass.logger(logger)
          expect(klass.instance_variable_get(:@logger)).to eq(optional_logger)
          expect(rv).to eq(optional_logger)
        end
      end

      context 'when the logger HAS previously been set' do
        it 'wraps given logger in an optional logger' do
          klass = Class.new do
            include OptionalLogger::LoggerManagement
          end

          old_logger = double('old logger')
          logger = double('logger')
          klass.instance_variable_set(:@logger, old_logger)
          expect(OptionalLogger::Logger).to receive(:new).with(logger)
          klass.logger(logger)
        end

        it 'stores the optional logger' do
          klass = Class.new do
            include OptionalLogger::LoggerManagement
          end

          old_logger = double('old logger')
          logger = double('logger')
          optional_logger = double('optional_logger')
          klass.instance_variable_set(:@logger, old_logger)
          allow(OptionalLogger::Logger).to receive(:new).with(logger).and_return(optional_logger)
          rv = klass.logger(logger)
          expect(klass.instance_variable_get(:@logger)).to eq(optional_logger)
          expect(rv).to eq(optional_logger)
        end
      end
    end

    context 'when not given a logger' do
      context 'when the logger has previously been set' do
        it 'returns the optional logger containing the previously set logger' do
          klass = Class.new do
            include OptionalLogger::LoggerManagement
          end

          logger = double('logger')
          klass.logger(logger)
          expect(klass.logger).to be_a(OptionalLogger::Logger)
          expect(klass.logger.wrapped_logger).to eq(logger)
        end
      end

      context 'when it has NOT previously been set' do
        it 'returns the optional logger' do
          klass = Class.new do
            include OptionalLogger::LoggerManagement
          end

          expect(klass.logger).to be_a(OptionalLogger::Logger)
          expect(klass.logger.wrapped_logger).to be_nil
        end
      end
    end
  end
end
