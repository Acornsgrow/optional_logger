[![Build Status](https://travis-ci.org/Acornsgrow/optional_logger.svg?branch=master)](https://travis-ci.org/Acornsgrow/optional_logger)
[![Code Climate](https://codeclimate.com/github/Acornsgrow/optional_logger/badges/gpa.svg)](https://codeclimate.com/github/Acornsgrow/optional_logger)
[![Test Coverage](https://codeclimate.com/github/Acornsgrow/optional_logger/badges/coverage.svg)](https://codeclimate.com/github/Acornsgrow/optional_logger/coverage)
[![Issue Count](https://codeclimate.com/github/Acornsgrow/optional_logger/badges/issue_count.svg)](https://codeclimate.com/github/Acornsgrow/optional_logger)
[![Inline docs](http://inch-ci.org/github/Acornsgrow/optional_logger.svg?branch=master)](http://inch-ci.org/github/Acornsgrow/optional_logger)

# OptionalLogger

Easily support application loggers in your gems.

## Why?

OptionalLogger was built out of the need to be able to easily support logging
inside of gems while still allowing the application to control the logger.

Generally, applications have to make a few decisions about a particular logger.

1. What log level should it be logging at?
2. Where should the logger be logging?
3. What format should this logger log in?

It is impossible for a gem to appropriately make these decisions as they are
strictly application level concerns that are made when constructing a `Logger`
instance.

OptionalLogger is a foundational component that enables gems to easily support
logging through an application managed logger. It does so by allowing the gem
authors to optionally receive a application managed Logger instance via
dependency injection and handles the optionality of the logger. This frees the
gem authors up from having to worry about checking for the existence of the
logger each time they want to log something. It also protects you from
accidentally altering the applications logger.

## Installation

Add this line to your gem's gemspec file:

```ruby
spec.add_dependency 'optional_logger', '~> 1.0'
```

Or install it yourself as:

```text
$ gem install optional_logger
```

## Usage

The assumption with the usage of OptionalLogger is that your gem some how
receives an application managed Logger instance via dependency injection.
OptionalLogger does NOT prescribe how you receive the logger. Therefore, the
following examples will refer to the received application managed logger
instance as `received_logger`.

```ruby
require 'optional_logger'

logger = OptionalLogger::Logger.new(received_logger)

logger.info("some info log message")
logger.info("Program Name") { "some expensive info log message" }
logger.info? # => Returns true if the current severity level allows for the printing of INFO messages.

logger.warn("some warn log message")
logger.warn("Program Name") { "some expensive warn log message" }
logger.warn? # => Returns true if the current severity level allows for the printing of WARN messages.

logger.debug("some debug log message")
logger.debug("Program Name") { "some expensive debug log message" }
logger.debug? # => Returns true if the current severity level allows for the printing of DEBUG messages.

logger.error("some error log message")
logger.error("Program Name") { "some expensive error log message" }
logger.error? # => Returns true if the current severity level allows for the printing of ERROR messages.

logger.fatal("some fatal log message")
logger.fatal("Program Name") { "some expensive fatal log message" }
logger.fatal? # => Returns true if the current severity level allows for the printing of FATAL messages.

logger.unknown("some unknown log message")
logger.unknown("Program Name") { "Some expensive unknown log message" }

logger.add(Logger::FATAL, nil, "Program Name") { "some expensive message" }
logger.add(Logger::FATAL, "some message", "Program Name")

logger.log(Logger::FATAL, nil, "Program Name") { "some expensive message" }
logger.log(Logger::FATAL, "some message", "Program Name")
```

**Note:** You don't have to worry about setting up or cleaning up after the
logger as it is managed by the application that is using your library.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/Acornsgrow/optional_logger. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

