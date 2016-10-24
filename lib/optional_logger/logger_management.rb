require 'optional_logger'

module OptionalLogger
  module LoggerManagement
    def logger(logger = nil)
      return @logger if @logger && logger.nil?
      @logger = OptionalLogger::Logger.new(logger)
    end
  end
end
