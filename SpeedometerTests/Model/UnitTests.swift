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

        XCTAssertEqual(unit.maximumSpeed, 240, "Maximum speed limit of km/h should equal 160")
    }

    func testUnitSpeedLimitSliderSteps() {
        let unit = Unit.kilometersPerHour

        XCTAssertEqual(unit.speedLimitSliderSteps, 5, "Speed limit slider steps of km/h should equal 5")
    }
}
