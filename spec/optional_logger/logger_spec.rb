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

  describe '#add' do
    context 'when logger is present' do
      let(:logger) { double('logger') }
      subject { described_class.new(logger) }

      it 'proxies #add to the logger #add' do
        severity = double('severity')
        message = double('message')
        progname = double('progname')
        block = Proc.new {}

        expect(logger).to receive(:add).with(severity, message, progname, &block)
        subject.add(severity, message, progname, &block)
      end

      context 'when progname is not passed' do
        it 'proxies #add to the logger #add with progname as nil' do
          severity = double('severity')
          message = double('message')
          block = Proc.new {}

          expect(logger).to receive(:add).with(severity, message, nil, &block)
          subject.add(severity, message, &block)
        end
      end

      context 'when progname and message are not passed' do
        it 'proxies #add to the logger #add with progname and message as nil' do
          severity = double('severity')
          block = Proc.new {}

          expect(logger).to receive(:add).with(severity, nil, nil, &block)
          subject.add(severity, &block)
        end
      end
    end

    context 'when logger is NOT present' do
      subject { described_class.new(nil) }

      it 'does NOT proxy #add to the logger #add' do
        severity = double('severity')
        message = double('message')
        progname = double('progname')
        block = Proc.new {}

        expect(subject.instance_variable_get(:@logger)).not_to receive(:add)
        subject.add(severity, message, progname, &block)
      end
    end
  end

  describe '#info' do
    let(:logger) { double('logger') }
    subject { described_class.new(logger) }

    context 'when give a message' do
      it 'logs the message as an info level message via #add' do
        message = 'my test message'
        expect(subject).to receive(:add).with(::Logger::INFO, nil, message)
        subject.info(message)
      end
    end

    context 'when given a block' do
      it 'logs the yielded value from the block with a nil progname' do
        message = 'my block test message'
        block = Proc.new { message }
        expect(subject).to receive(:add).with(::Logger::INFO, nil, nil, &block)
        subject.info(&block)
      end
    end

    context 'when given a block and progname' do
      it 'logs the yielded value from the block with the progname' do
        message = 'my block test message'
        progname = 'my progname'
        block = Proc.new { message }
        expect(subject).to receive(:add).with(::Logger::INFO, nil, progname, &block)
        subject.info(progname, &block)
      end
    end
  end

  describe '#warn' do
    let(:logger) { double('logger') }
    subject { described_class.new(logger) }

    context 'when give a message' do
      it 'logs the message as an warn level message via #add' do
        message = 'my test message'
        expect(subject).to receive(:add).with(::Logger::WARN, nil, message)
        subject.warn(message)
      end
    end

    context 'when given a block' do
      it 'logs the yielded value from the block with a nil progname' do
        message = 'my block test message'
        block = Proc.new { message }
        expect(subject).to receive(:add).with(::Logger::WARN, nil, nil, &block)
        subject.warn(&block)
      end
    end

    context 'when given a block and progname' do
      it 'logs the yielded value from the block with the progname' do
        message = 'my block test message'
        progname = 'my progname'
        block = Proc.new { message }
        expect(subject).to receive(:add).with(::Logger::WARN, nil, progname, &block)
        subject.warn(progname, &block)
      end
    end
  end
end
