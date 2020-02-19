import XCTest
@testable import Speedometer

class SpeedTests: XCTestCase {
    func testConvertedSpeed() {
        let unit = Unit.kilometersPerHour
        let speed = Speed(of: 10, as: unit)

        XCTAssertEqual(speed.localizedString, "36")
    }
}
