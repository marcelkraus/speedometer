import XCTest
@testable import Speedometer

class SpeedTests: XCTestCase {
    func testConvertedSpeed() {
        let unit = Unit.kilometersPerHour
        let speed = Speed(speed: 10, unit: unit)

        XCTAssertEqual(speed.localizedString, "36")
    }
}
