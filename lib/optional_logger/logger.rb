require 'logger'

module OptionalLogger
  # Proxy logger to handle making the proxied logger optional
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

    # Log a message at the given level if the logger is present
    #
    # This isn't generally a recommended method to use while logging in your
    # libraries. Instead see {#debug}, {#info}, {#warn}, {#error}, {#fatal}, and
    # {#unknown} as they simplify messaging considerably.
    #
    # If you don't want to use the recommended methods and want more control for
    # some reason. There are a few ways to log a message depending on your usecase.
    #
    # The first is probably the most generally useful, which is logging messages
    # that aren't costly to build. This is accomplished as follows:
    #
    #     add(::Logger::INFO, 'some message', nil)
    #
    # The second is for use cases in which it is costly to build the log message
    # as it avoids executing the block until the logger knows that the message
    # level will be displayed. If the message level would not be displayed then
    # the block is not executed, saving the performance cost of building the
    # message.
    #
    #     add(::Logger::INFO) { 'some expensive message' }
    #
    # The third gives you the benefits of preventing uneeded expensive messages
    # but also allows you to override the program name that will be prefixed on
    # that log message. This is accomplished as follows.
    #
    #     add(::Logger::INFO, nil, 'overridden progname') { 'some expensive message' }
    #
    # It is important to realize that if the wrapped logger is nil then this
    # method will simply do nothing.
    #
    # @param severity ::Logger::DEBUG, ::Logger::INFO, ::Logger::WARN,
    #   ::Logger::ERROR, ::Logger::FATAL, ::Logger::UNKNOWN
    # @param message the optional message to log
    # @param progname_or_message the optional program name or message, if
    #   message is nil, and a block is NOT provided, then progname_or_message is
    #   treated as a message rather than progname
    # @param block the block to evaluate and yield a message, generally useful
    #   preventing building of expensive messages when message of that level
    #   aren't allowed
    def add(severity, message = nil, progname_or_message = nil, &block)
      @logger.add(severity, message, progname_or_message, &block) if @logger
    end
    alias log add

    # Log a message at the info level if the logger is present
    #
    # There are a few ways to log a message depending on your usecase.
    #
    # The first is probably the most generally useful, which is logging messages
    # that aren't costly to build. This is accomplished as follows:
    #
    #     info('some message')
    #
    # The second is for use cases in which it is costly to build the log message
    # as it avoids executing the block until the logger knows that the message
    # level will be displayed. If the message level would not be displayed then
    # the block is not executed, saving the performance cost of building the
    # message.
    #
    #     info { 'some expensive message' }
    #
    # The third gives you the benefits of preventing uneeded expensive messages
    # but also allows you to override the program name that will be prefixed on
    # that log message. This is accomplished as follows.
    #
    #     info('overridden progname') { 'some expensive message' }
    #
    # It is important to realize that if the wrapped logger is nil then this
    # method will simply do nothing.
    #
    # @param progname_or_message the progname or message depending on scenario
    # @param block the optional block depending on scenario
    def info(progname_or_message = nil, &block)
      add(::Logger::INFO, nil, progname_or_message, &block)
    end

    # Log a message at the warn level if the logger is present
    #
    # See {#info} for details on specifics around various scenarios
    def warn(progname_or_message = nil, &block)
      add(::Logger::WARN, nil, progname_or_message, &block)
    end

    # Log a message at the debug level if the logger is present
    #
    # See {#info} for details on specifics around various scenarios
    def debug(progname_or_message = nil, &block)
      add(::Logger::DEBUG, nil, progname_or_message, &block)
    end

    # Log a message at the error level if the logger is present
    #
    # See {#info} for details on specifics around various scenarios
    def error(progname_or_message = nil, &block)
      add(::Logger::ERROR, nil, progname_or_message, &block)
    end

    # Log a message at the fatal level if the logger is present
    #
    # See {#info} for details on specifics around various scenarios
    def fatal(progname_or_message = nil, &block)
      add(::Logger::FATAL, nil, progname_or_message, &block)
    end

    # Log a message at the unknown level if the logger is present
    #
    # See {#info} for details on specifics around various scenarios
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
