# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Changed

- Migrated to new String Catalogs for localization
- Set minimum iOS version to iOS 16.6
- Updated RevenueCat SDK to version 4.41.2

## [Version 1.3.1] - 2022-08-25

### Changed

- Set minimum iOS version to iOS 13.0
- Switched to automatic signing
- Updated project to remove all warnings with Xcode 13.4.1
- Updated RevenueCat SDK to version 4.5.1
- Updated some copywriting

## [Version 1.3] - 2020-10-03

### Added

- Added support for iOS Dark Mode
- Added three more color schemes with alternate app icons (after an optional tip)

### Changed

- Replaced Apple In-App purchase logic with RevenueCat In-App purchase logic

## [Version 1.2.1] - 2020-08-10

### Fixed

- Fixed a possible crash while fetching the selected `Unit` using the string based identifier from `UserDefaults`

## [Version 1.2] - 2020-06-08

### Added

- Added new unit "split500" ("min./500m")
- Added the tip jar on the new settings screen

### Changed

- Updated the authors address
- Updated the imprint screen to a scrollable settings screen
- Updated the models to make calculations for new unit possible
- Updated the project structure

## [Version 1.1.1] - 2019-07-29

### Added

- Added the review dialog if applicable (this was erroneously removed with v1.1)

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
