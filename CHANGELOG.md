# ChangeLog

The following are lists of the notable changes included with each release.
This is intended to help keep people informed about notable changes between
versions, as well as provide a rough history. Each item is prefixed with
one of the following labels: `Added`, `Changed`, `Deprecated`,
`Removed`, `Fixed`, `Security`. We also use [Semantic
Versioning](http://semver.org) to manage the versions of this gem so
that you can set version constraints properly.

#### Next Release

#### [v2.0.0] - 2016-10-24

* Changed logger management to work at class or instance level

#### [v1.1.0] - 2016-10-18

* Added logger management module

#### [v1.0.0] - 2016-10-11

* Added documentation around all the classes, modules, constants and methods
* Added OptionalLogger::Logger level introspection methods (#debug?, #info?,
  #warn?, #error?, #fatal?)
* Added OptionalLogger::Logger level convenience methods (#debug, #info, #warn,
  #error, #fatal, #unknown)
* Added OptionalLogger::Logger#add and #log methods
* Added OptionalLogger::Logger class and constructor
* Added OptionalLogger module skeleton

[Unreleased]: https://github.com/Acornsgrow/optional_logger/compare/v2.0.0...HEAD
[v2.0.0]: https://github.com/Acornsgrow/optional_logger/compare/v1.1.0...v2.0.0
[v1.1.0]: https://github.com/Acornsgrow/optional_logger/compare/v1.0.0...v1.1.0
[v1.0.0]: https://github.com/Acornsgrow/optional_logger/compare/d377eb0...v1.0.0
