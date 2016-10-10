require 'spec_helper'

describe OptionalLogger do
  it 'has a version number' do
    expect(OptionalLogger::VERSION).not_to be nil
  end

  describe '.new' do
    it 'constructs a new OptionalLogger::Logger instance' do
      log_content = StringIO.new
      logger = ::Logger.new(log_content)
      optional_logger = OptionalLogger::Logger.new(logger)
      expect(optional_logger).to be_a(OptionalLogger::Logger)
    end
  end

  describe '#wrapped_logger' do
    it 'returns the logger it was constructed with' do
      log_content = StringIO.new
      logger = ::Logger.new(log_content)
      optional_logger = OptionalLogger::Logger.new(logger)
      expect(optional_logger.wrapped_logger).to eq(logger)
    end
  end

  describe '#add' do
    context 'when given message' do
      context 'when given progname' do
        context 'when given block' do
          it 'add log message containing level, message, and progname to log ignoring the block' do
            log_content = StringIO.new
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.add(::Logger::INFO, 'my message', 'my prog') { 'some ignored block message' }
            log_content.rewind
            expect(log_content.read).to match(/INFO -- my prog: my message$/)
          end
        end

        context 'when NOT given block' do
          it 'add log message containing level, message, and progname to the log ' do
            log_content = StringIO.new
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.add(::Logger::INFO, 'my message', 'my prog')
            log_content.rewind
            expect(log_content.read).to match(/INFO -- my prog: my message$/)
          end
        end
      end

      context 'when NOT given progname' do
        context 'when given block' do
          it 'add log message containing level, and message to log ignoring the block' do
            log_content = StringIO.new
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.add(::Logger::INFO, 'my message') { 'some ignored block message' }
            log_content.rewind
            expect(log_content.read).to match(/INFO -- : my message$/)
          end
        end

        context 'when NOT given block' do
          it 'add log message containing level, and message to log' do
            log_content = StringIO.new
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.add(::Logger::INFO, 'my message')
            log_content.rewind
            expect(log_content.read).to match(/INFO -- : my message$/)
          end
        end
      end
    end

    context 'when message is nil' do
      context 'when given progname' do
        context 'when given block' do
          it 'add log message containing level, block provided message, and progname to log' do
            log_content = StringIO.new
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.add(::Logger::INFO, nil, 'my prog') { 'some block message' }
            log_content.rewind
            expect(log_content.read).to match(/INFO -- my prog: some block message$/)
          end
        end

        context 'when NOT given block' do
          it 'add log message containing level, and progname as the message to log' do
            log_content = StringIO.new
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.add(::Logger::INFO, nil, 'my prog')
            log_content.rewind
            expect(log_content.read).to match(/INFO -- : my prog$/)
          end
        end
      end

      context 'when progname is nil' do
        context 'when given block' do
          it 'add log message containing level, and block yielded message to log' do
            log_content = StringIO.new
            logger = ::Logger.new(log_content)
            optional_logger = OptionalLogger::Logger.new(logger)
            optional_logger.add(::Logger::INFO, nil, nil) { 'some block message' }
            log_content.rewind
            expect(log_content.read).to match(/INFO -- : some block message$/)
          end
        end
      end
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
      context 'when given message_or_progname' do
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

      context 'when NOT given message_or_progname' do
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
      context 'when given a message_or_progname' do
        it 'logs an info severity level message' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.info('my message')
          log_content.rewind
          expect(log_content.read).to match(/INFO -- : my message$/)
        end
      end
    end
  end

  describe '#warn' do
    context 'when given a block' do
      context 'when given message_or_progname' do
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

      context 'when NOT given message_or_progname' do
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
      context 'when given a message_or_progname' do
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
  end

  describe '#debug' do
    context 'when given a block' do
      context 'when given message_or_progname' do
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

      context 'when NOT given message_or_progname' do
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
      context 'when given a message_or_progname' do
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

  describe '#error' do
    context 'when given a block' do
      context 'when given message_or_progname' do
        it 'logs an error severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.error('my progname', &block)
          log_content.rewind
          expect(log_content.read).to match(/ERROR -- my progname: my test message$/)
        end
      end

      context 'when NOT given message_or_progname' do
        it 'logs an error severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.error(&block)
          log_content.rewind
          expect(log_content.read).to match(/ERROR -- : my test message$/)
        end
      end
    end

    context 'when not given a block' do
      context 'when given a message_or_progname' do
        it 'logs an error severity level message' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.error('my message')
          log_content.rewind
          expect(log_content.read).to match(/ERROR -- : my message$/)
        end
      end
    end
  end

  describe '#fatal' do
    context 'when given a block' do
      context 'when given message_or_progname' do
        it 'logs an fatal severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.fatal('my progname', &block)
          log_content.rewind
          expect(log_content.read).to match(/FATAL -- my progname: my test message$/)
        end
      end

      context 'when NOT given message_or_progname' do
        it 'logs an fatal severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.fatal(&block)
          log_content.rewind
          expect(log_content.read).to match(/FATAL -- : my test message$/)
        end
      end
    end

    context 'when not given a block' do
      context 'when given a message_or_progname' do
        it 'logs an fatal severity level message' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.fatal('my message')
          log_content.rewind
          expect(log_content.read).to match(/FATAL -- : my message$/)
        end
      end
    end
  end

  describe '#unknown' do
    context 'when given a block' do
      context 'when given message_or_progname' do
        it 'logs an unknown severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.unknown('my progname', &block)
          log_content.rewind
          expect(log_content.read).to match(/ANY -- my progname: my test message$/)
        end
      end

      context 'when NOT given message_or_progname' do
        it 'logs an unknown severity level message' do
          log_content = StringIO.new
          message = 'my test message'
          block = Proc.new { message }
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.unknown(&block)
          log_content.rewind
          expect(log_content.read).to match(/ANY -- : my test message$/)
        end
      end
    end

    context 'when not given a block' do
      context 'when given message_or_progname' do
        it 'logs an unknown severity level message' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          optional_logger = OptionalLogger::Logger.new(logger)
          optional_logger.unknown('my message')
          log_content.rewind
          expect(log_content.read).to match(/ANY -- : my message$/)
        end
      end
    end
  end

  describe '#info?' do
    context 'when logger present' do
      context 'when current severity level allows for info messages' do
        it 'returns true' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          logger.level = ::Logger::INFO
          optional_logger = OptionalLogger::Logger.new(logger)

          expect(optional_logger.info?).to eq(true)
        end
      end

      context 'when the current severity does not allow for info messages' do
        it 'returns false' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          logger.level = ::Logger::UNKNOWN
          optional_logger = OptionalLogger::Logger.new(logger)

          expect(optional_logger.info?).to eq(false)
        end
      end
    end

    context 'when logger NOT present' do
      it 'returns false' do
        optional_logger = OptionalLogger::Logger.new(nil)
        expect(optional_logger.info?).to eq(false)
      end
    end
  end

  describe '#warn?' do
    context 'when logger present' do
      context 'when current severity level allows for warn messages' do
        it 'returns true' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          logger.level = ::Logger::INFO
          optional_logger = OptionalLogger::Logger.new(logger)

          expect(optional_logger.warn?).to eq(true)
        end
      end

      context 'when the current severity does not allow for warn messages' do
        it 'returns false' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          logger.level = ::Logger::UNKNOWN
          optional_logger = OptionalLogger::Logger.new(logger)

          expect(optional_logger.warn?).to eq(false)
        end
      end
    end

    context 'when logger NOT present' do
      it 'returns false' do
        optional_logger = OptionalLogger::Logger.new(nil)
        expect(optional_logger.warn?).to eq(false)
      end
    end
  end

  describe '#debug?' do
    context 'when logger present' do
      context 'when current severity level allows for debug messages' do
        it 'returns true' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          logger.level = ::Logger::DEBUG
          optional_logger = OptionalLogger::Logger.new(logger)

          expect(optional_logger.debug?).to eq(true)
        end
      end

      context 'when the current severity does not allow for debug messages' do
        it 'returns false' do
          log_content = StringIO.new
          logger = ::Logger.new(log_content)
          logger.level = ::Logger::UNKNOWN
          optional_logger = OptionalLogger::Logger.new(logger)

          expect(optional_logger.debug?).to eq(false)
        end
      end
    end

    context 'when logger NOT present' do
      it 'returns false' do
        optional_logger = OptionalLogger::Logger.new(nil)
        expect(optional_logger.debug?).to eq(false)
      end
    end
  end
end
