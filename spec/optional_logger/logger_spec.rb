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

    it 'calls the add method appropriately' do
      message = 'my test message'
      block = Proc.new { }
      expect(subject).to receive(:add).with(::Logger::INFO, nil, message, &block)
      subject.info(message, &block)
    end
  end

  describe '#warn' do
    let(:logger) { double('logger') }
    subject { described_class.new(logger) }

    it 'calls the add method appropriately' do
      message = 'my test message'
      block = Proc.new { }
      expect(subject).to receive(:add).with(::Logger::WARN, nil, message, &block)
      subject.warn(message, &block)
    end
  end

  describe '#debug' do
    let(:logger) { double('logger') }
    subject { described_class.new(logger) }

    it 'calls the add method appropriately' do
      message = 'my test message'
      block = Proc.new { }
      expect(subject).to receive(:add).with(::Logger::DEBUG, nil, message, &block)
      subject.debug(message, &block)
    end
  end

  describe '#error' do
    let(:logger) { double('logger') }
    subject { described_class.new(logger) }

    it 'calls the add method appropriately' do
      message = 'my test message'
      block = Proc.new { }
      expect(subject).to receive(:add).with(::Logger::ERROR, nil, message, &block)
      subject.error(message, &block)
    end
  end

  describe '#fatal' do
    let(:logger) { double('logger') }
    subject { described_class.new(logger) }

    it 'calls the add method appropriately' do
      message = 'my test message'
      block = Proc.new { }
      expect(subject).to receive(:add).with(::Logger::FATAL, nil, message, &block)
      subject.fatal(message, &block)
    end
  end

  describe '#unknown' do
    let(:logger) { double('logger') }
    subject { described_class.new(logger) }

    it 'calls the add method appropriately' do
      message = 'my test message'
      block = Proc.new { }
      expect(subject).to receive(:add).with(::Logger::UNKNOWN, nil, message, &block)
      subject.unknown(message, &block)
    end
  end
end
