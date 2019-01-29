import XCTest
@testable import Speedometer

class UnitTests: XCTestCase {
    func testUnitAbbreviation() {
        let unit = Unit.kilometersPerHour

        XCTAssertEqual(unit.abbreviation, "km/h", "Abbreviation of kilometers per hour should equal km/h")
    }

    func testUnitFactor() {
        let unit = Unit.kilometersPerHour

        XCTAssertEqual(unit.factor, 3.6, "Factor of km/h should equal 3.6")
    }

    func testUnitMaxiumSpeed() {
        let unit = Unit.kilometersPerHour

        XCTAssertEqual(unit.maximumSpeed, 240, "Maximum speed of km/h should equal 160")
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

    func testKilometersPerHourIsNextUnitAfterKnots() {
        let unit = Unit.knots

        let nextUnit = unit.next

        XCTAssertEqual(nextUnit, Unit.kilometersPerHour)
    }
}
