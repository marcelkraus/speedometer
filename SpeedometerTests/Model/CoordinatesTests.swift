import XCTest
@testable import Speedometer

class CoordinatesTests: XCTestCase {
    func testLatitude() {
        let coordinates = Coordinates(latitude: 38.898556, longitude: 0)

        XCTAssertEqual("38° 53\' 55\" North", coordinates.formatted.latitude)
    }

    func testLongitude() {
        let coordinates = Coordinates(latitude: 0, longitude: -77.037852)

        XCTAssertEqual("77° 2\' 16\" West", coordinates.formatted.longitude)
    }
}
