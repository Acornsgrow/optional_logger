require 'optional_logger'

module OptionalLogger
  module LoggerManagement
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def logger(logger = nil)
        return @logger if @logger && logger.nil?
        @logger = OptionalLogger::Logger.new(logger)
      end
    end
  end
end
