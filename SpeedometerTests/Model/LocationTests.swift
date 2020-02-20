import XCTest
@testable import Speedometer

class LocationTests: XCTestCase {
    func testNumericalPartOfLatitude() {
        let location = Location(latitude: 38.898556, longitude: 0)

        XCTAssertTrue(location.localizedString.latitude.starts(with: "38° 53\' 55\""))
    }

    func testNumericalPartOfLongitude() {
        let location = Location(latitude: 0, longitude: -77.037852)

        XCTAssertTrue(location.localizedString.longitude.starts(with: "77° 2\' 16\""))
    }
}
