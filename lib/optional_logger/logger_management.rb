require 'optional_logger'

module OptionalLogger
  module LoggerManagement
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def logger(logger = nil)
        if logger.nil?
          @logger = OptionalLogger::Logger.new(nil) if @logger.nil?
        else
          @logger = OptionalLogger::Logger.new(logger)
        end
        return @logger
      end
    end
  end
end
