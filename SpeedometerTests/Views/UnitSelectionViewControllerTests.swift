import XCTest
@testable import Speedometer

class UnitSelectionViewControllerTests: XCTestCase {
    func testStackViewIsHidden() {
        let unitSelectionViewController = UnitSelectionViewController(hideStackView: true)
        unitSelectionViewController.loadViewIfNeeded()

        XCTAssertTrue(unitSelectionViewController.stackView.isHidden)
    }

    func testStackViewIsVisible() {
        let unitSelectionViewController = UnitSelectionViewController(hideStackView: false)
        unitSelectionViewController.loadViewIfNeeded()

        XCTAssertFalse(unitSelectionViewController.stackView.isHidden)
    }

    func testNumberOfSegments() {
        let unitSelectionViewController = UnitSelectionViewController(hideStackView: false)
        unitSelectionViewController.loadViewIfNeeded()

        let segmentedControl = unitSelectionViewController.segmentedControl!
        let expectedNumberOfSegments = units.count

        XCTAssertEqual(segmentedControl.numberOfSegments, expectedNumberOfSegments)
    }

    func testContentOfSegments() {
        let unitSelectionViewController = UnitSelectionViewController(hideStackView: false)
        unitSelectionViewController.loadViewIfNeeded()

        let segmentedControl = unitSelectionViewController.segmentedControl!
        let enumeratedUnits = units.enumerated()

        enumeratedUnits.forEach { (index, unit) in
            XCTAssertEqual(segmentedControl.titleForSegment(at: index), unit.abbreviation)
        }
    }
}
