require 'spec_helper'

describe OptionalLogger do
  it 'has a version number' do
    expect(OptionalLogger::VERSION).not_to be nil
  end

  it 'add log message to log' do
    log_content = StringIO.new
    logger = Logger.new(log_content)
    optional_logger = OptionalLogger::Logger.new(logger)
    optional_logger.add(Logger::INFO, 'my message', 'my prog')
    log_content.rewind
    expect(log_content.read).to match(/INFO -- my prog: my message$/)
  end
end
