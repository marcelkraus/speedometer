import XCTest
@testable import Speedometer

class CoordinatesTests: XCTestCase {
    func testNumericalPartOfLatitude() {
        let coordinates = Coordinates(latitude: 38.898556, longitude: 0)

        XCTAssertTrue(coordinates.formatted.latitude.starts(with: "38° 53\' 55\""))
    }

    func testNumericalPartOfLongitude() {
        let coordinates = Coordinates(latitude: 0, longitude: -77.037852)

        XCTAssertTrue(coordinates.formatted.longitude.starts(with: "77° 2\' 16\""))
    }
}
