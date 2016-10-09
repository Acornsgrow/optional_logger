module OptionalLogger
  class Logger
    def initialize(logger)
      @logger = logger
    end

    def add(severity, message = nil, progname = nil, &block)
      @logger.add(severity, message, progname, &block) if @logger
    end
  end
end
