require 'logger'

module OptionalLogger
  class Logger
    def initialize(logger)
      @logger = logger
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
  end
end
