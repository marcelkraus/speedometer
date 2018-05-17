import XCTest
@testable import Speedometer

class SpeedTests: XCTestCase {
    func testConvertedSpeed() {
        let unit = Unit.kilometersPerHour
        let speed = Speed(speed: 10, unit: unit, speedLimit: 0)

        XCTAssertEqual(speed.asString, "36", "Converted speed of 10 m/s should equal 36 km/h")
    }

    func testSpeedLimit() {
        let unit = Unit.kilometersPerHour
        let speed = Speed(speed: 60, unit: unit, speedLimit: 120)

        XCTAssertTrue(speed.limitIsExceeded, "Speed above 200 km/h should exceed speed limit of 120 km/h")
    }
}
