require 'spec_helper'

describe OptionalLogger do
  it 'has a version number' do
    expect(OptionalLogger::VERSION).not_to be nil
  end

  describe '#add' do
    it 'add log message to log' do
      log_content = StringIO.new
      logger = ::Logger.new(log_content)
      optional_logger = OptionalLogger::Logger.new(logger)
      optional_logger.add(::Logger::INFO, 'my message', 'my prog')
      log_content.rewind
      expect(log_content.read).to match(/INFO -- my prog: my message$/)
    end
  end

  describe '#log' do
    it 'add log message to log using' do
      log_content = StringIO.new
      logger = ::Logger.new(log_content)
      optional_logger = OptionalLogger::Logger.new(logger)
      optional_logger.log(::Logger::INFO, 'my message', 'my prog')
      log_content.rewind
      expect(log_content.read).to match(/INFO -- my prog: my message$/)
    end
  end

  describe '#info' do
    context 'when given a block' do
      context 'when given progname' do
        it 'logs an info severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.info('my progname', &block)
          log_content.rewind
          expect(log_content.read).to match(/INFO -- my progname: my test message$/)
        end
      end

      context 'when NOT given progname' do
        it 'logs an info severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.info(&block)
          log_content.rewind
          expect(log_content.read).to match(/INFO -- : my test message$/)
        end
      end
    end

    context 'when not given a block' do
      it 'logs an info severity level message' do
        log_content = StringIO.new
        logger = ::Logger.new(log_content)
        optional_logger = OptionalLogger::Logger.new(logger)
        optional_logger.info('my message')
        log_content.rewind
        expect(log_content.read).to match(/INFO -- : my message$/)
      end
    end

    describe '#warn' do
      context 'when given a block' do
        context 'when given progname' do
          it 'logs an warn severity level message' do
            log_content = StringIO.new
            message = 'my test message'
            block = Proc.new { message }
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.warn('my progname', &block)
            log_content.rewind
            expect(log_content.read).to match(/WARN -- my progname: my test message$/)
          end
        end

        context 'when NOT given progname' do
          it 'logs an warn severity level message' do
            log_content = StringIO.new
            message = 'my test message'
            block = Proc.new { message }
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.warn(&block)
            log_content.rewind
            expect(log_content.read).to match(/WARN -- : my test message$/)
          end
        end
      end

      context 'when not given a block' do
        it 'logs an warn severity level message' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.warn('my message')
          log_content.rewind
          expect(log_content.read).to match(/WARN -- : my message$/)
        end
      end
    end

    describe '#debug' do
      context 'when given a block' do
        context 'when given progname' do
          it 'logs an debug severity level message' do
            log_content = StringIO.new
            message = 'my test message'
            block = Proc.new { message }
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.debug('my progname', &block)
            log_content.rewind
            expect(log_content.read).to match(/DEBUG -- my progname: my test message$/)
          end
        end

        context 'when NOT given progname' do
          it 'logs an debug severity level message' do
            log_content = StringIO.new
            message = 'my test message'
            block = Proc.new { message }
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.debug(&block)
            log_content.rewind
            expect(log_content.read).to match(/DEBUG -- : my test message$/)
          end
        end
      end

      context 'when not given a block' do
        it 'logs an debug severity level message' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.debug('my message')
          log_content.rewind
          expect(log_content.read).to match(/DEBUG -- : my message$/)
        end
      end
    end
  end
end
