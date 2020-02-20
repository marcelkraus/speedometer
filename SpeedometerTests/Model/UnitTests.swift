import XCTest
@testable import Speedometer

class UnitTests: XCTestCase {
    func testUnitAbbreviation() {
        let unit = Unit.kilometersPerHour

        XCTAssertEqual(unit.rawValue, "km/h")
    }

    func testUnitSpeedCalculationRespectsMinimumValue() {
        let unit = Unit.milesPerHour

        XCTAssertEqual(unit.calculate(for: 0.49), 0.0)
    }

    func testUnitSpeedCalculationReturnsValidSpeed() {
        let unit = Unit.kilometersPerHour

        XCTAssertEqual(unit.calculate(for: 1.0), 3.6)
    }

    func testMilesPerHourIsNextUnitAfterKilometersPerHour() {
        let unit = Unit.kilometersPerHour

        let nextUnit = unit.next

        XCTAssertEqual(nextUnit, Unit.milesPerHour)
    }

    func testMetersPerSecondIsNextUnitAfterMilesPerHour() {
        let unit = Unit.milesPerHour

        let nextUnit = unit.next

        XCTAssertEqual(nextUnit, Unit.metersPerSecond)
    }

    func testKnotsIsNextUnitAfterMetersPerSecond() {
        let unit = Unit.metersPerSecond

        let nextUnit = unit.next

        XCTAssertEqual(nextUnit, Unit.knots)
    }

    func testSplit500IsNextUnitAfterKnots() {
        let unit = Unit.knots

        let nextUnit = unit.next

        XCTAssertEqual(nextUnit, Unit.split500)
    }

    func testKilometersPerHourIsNextUnitAfterSplit500() {
        let unit = Unit.split500

        let nextUnit = unit.next

        XCTAssertEqual(nextUnit, Unit.kilometersPerHour)
    }

    func testConvertedSpeed() {
        let unit = Unit.kilometersPerHour
        let speed = unit.calculate(for: 10)

        XCTAssertEqual(speed, 36)
    }
}
