@testable import Speedometer
import XCTest

class DistanceTests: XCTestCase {
    override func setUp() {
        super.setUp()

        Distance.reset()
    }

    func testInitialDistanceIsZero() {
        XCTAssertEqual(Distance.totalMeters, 0)
    }

    func testAccumulateAddsDistance() {
        Distance.accumulate(deltaMeters: 100.0, speed: 5.0)

        XCTAssertEqual(Distance.totalMeters, 100.0)
    }

    func testAccumulateIgnoresBelowMinimumSpeed() {
        Distance.accumulate(deltaMeters: 100.0, speed: 0.49)

        XCTAssertEqual(Distance.totalMeters, 0)
    }

    func testAccumulateIgnoresNegativeDelta() {
        Distance.accumulate(deltaMeters: -10.0, speed: 5.0)

        XCTAssertEqual(Distance.totalMeters, 0)
    }

    func testAccumulateAddsMultipleDeltas() {
        Distance.accumulate(deltaMeters: 100.0, speed: 5.0)
        Distance.accumulate(deltaMeters: 200.0, speed: 10.0)

        XCTAssertEqual(Distance.totalMeters, 300.0)
    }

    func testResetSetsDistanceToZero() {
        Distance.accumulate(deltaMeters: 500.0, speed: 5.0)

        Distance.reset()

        XCTAssertEqual(Distance.totalMeters, 0)
    }

    func testConvertedDistanceForKilometersPerHour() {
        Distance.accumulate(deltaMeters: 1000.0, speed: 5.0)

        XCTAssertEqual(Distance.convertedDistance(for: .kilometersPerHour), 1.0)
    }

    func testConvertedDistanceForMilesPerHour() {
        Distance.accumulate(deltaMeters: 1609.344, speed: 5.0)

        XCTAssertEqual(Distance.convertedDistance(for: .milesPerHour), 1.0, accuracy: 0.001)
    }

    func testConvertedDistanceForMetersPerSecond() {
        Distance.accumulate(deltaMeters: 500.0, speed: 5.0)

        XCTAssertEqual(Distance.convertedDistance(for: .metersPerSecond), 500.0)
    }

    func testConvertedDistanceForKnots() {
        Distance.accumulate(deltaMeters: 1852.0, speed: 5.0)

        XCTAssertEqual(Distance.convertedDistance(for: .knots), 1.0, accuracy: 0.001)
    }
}
