require 'logger'

module OptionalLogger
  # Proxy logger to handle making the proxied logged optional
  #
  # The original intent for this optional proxy logger was specifically to be
  # used inside of gems. This would enable them to receive a logger from the
  # parenting application/gem and log within their gem without having to worry
  # about spreading conditionals all over their gem.
  class Logger
    # Construct an instance of the proxy logger
    #
    # @param logger [#add,#info?,#warn?,#debug?,#fatal?,#error?] the ruby logger
    #   to wrap
    # @return the instance of the proxy logger
    def initialize(logger)
      @logger = logger
    end

    # Get the ruby logger instance this proxy logger wraps
    #
    # @return the wrapped ruby logger
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

    # Check if info level messages are allowed by loggers current configuration
    #
    # @return [Boolean] true if the current severity level allows for the
    #   printing of info messages and false otherwise. It will also return false
    #   if there is no logger present.
    def info?
      return @logger.info? if @logger
      false
    end

    # Check if warn level messages are allowed by loggers current configuration
    #
    # @return [Boolean] true if the current severity level allows for the
    #   printing of warn messages and false otherwise. It will also return false
    #   if there is no logger present.
    def warn?
      return @logger.warn? if @logger
      false
    end

    # Check if debug level messages are allowed by loggers current configuration
    #
    # @return [Boolean] true if the current severity level allows for the
    #   printing of debug messages and false otherwise. It will also return false
    #   if there is no logger present.
    def debug?
      return @logger.debug? if @logger
      false
    end

    # Check if fatal level messages are allowed by loggers current configuration
    #
    # @return [Boolean] true if the current severity level allows for the
    #   printing of fatal messages and false otherwise. It will also return false
    #   if there is no logger present.
    def fatal?
      return @logger.fatal? if @logger
      false
    end

    # Check if error level messages are allowed by loggers current configuration
    #
    # @return [Boolean] true if the current severity level allows for the
    #   printing of error messages and false otherwise. It will also return false
    #   if there is no logger present.
    def error?
      return @logger.error? if @logger
      false
    end
  end
end
