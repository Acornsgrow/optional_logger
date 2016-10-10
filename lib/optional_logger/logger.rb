require 'logger'

module OptionalLogger
  class Logger
    def initialize(logger)
      @logger = logger
    end

    def wrapped_logger
      @logger
    end

    def add(severity, message = nil, progname = nil, &block)
      @logger.add(severity, message, progname, &block) if @logger
    end
    alias log add

    def info(progname_or_message = nil, &block)
      add(::Logger::INFO, nil, progname_or_message, &block)
    end

    def warn(progname_or_message = nil, &block)
      add(::Logger::WARN, nil, progname_or_message, &block)
    end

    def debug(progname_or_message = nil, &block)
      add(::Logger::DEBUG, nil, progname_or_message, &block)
    end

    def error(progname_or_message = nil, &block)
      add(::Logger::ERROR, nil, progname_or_message, &block)
    end

    def fatal(progname_or_message = nil, &block)
      add(::Logger::FATAL, nil, progname_or_message, &block)
    end

    def unknown(progname_or_message = nil, &block)
      add(::Logger::UNKNOWN, nil, progname_or_message, &block)
    end

    def info?
      return @logger.info? if @logger
      false
    end

    def warn?
      return @logger.warn? if @logger
      false
    end

    def debug?
      return @logger.debug? if @logger
      false
    end

    def fatal?
      return @logger.fatal? if @logger
      false
    end

    def error?
      return @logger.error? if @logger
      false
    end
  end
end
