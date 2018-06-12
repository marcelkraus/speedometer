import XCTest
@testable import Speedometer

class SpeedTests: XCTestCase {
    func testConvertedSpeed() {
        let unit = Unit.kilometersPerHour
        let speed = Speed(speed: 10, unit: unit)

        XCTAssertEqual(speed.asString, "36", "Converted speed of 10 m/s should equal 36 km/h")
    }
}
