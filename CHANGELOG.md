# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Version 1.1] - 2019-04-25

### Changed

- Reduced the usage of `CLLocationManager` instances to one
- Migrated the "Massive View Controllers" to a container-based approach with smaller view controllers, based on the ["A Better MVC"](https://davedelong.com/blog/2017/11/06/a-better-mvc-part-1-the-problems/) series of Dave DeLong
- Migrated the project to use code instead of Storyboard and Interface Builder

### Removed

- Removed the "speed limiter" feature

## [Version 1.0.1] - 2018-07-30

### Added

- Made default unit dependent of usage of metric system

### Changed

- Changed amount of required sessions between requests of rating dialogs
- Changed styling of imprint screen
- Changed `minimumHorizontalAccuracy` value for `CLLocationManager`
- Changed project architecture to use Storyboard and Interface Builder

## [Version 1.0] - 2018-07-01

### Added

- Added "coordinates" feature
- Added "speed limiter" feature
- Added "knots" as fourth unit of speed
- Added visualization (half circle) of current speed

### Changed

- Changed styling of all screens

## [Version 1.0-RC1] - Unreleased

This version was submitted for review, but never passed the review. The App Store team gave feedback that the app was too simple (useless?) at that time.
