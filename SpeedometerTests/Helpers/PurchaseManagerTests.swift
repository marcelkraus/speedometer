@testable import Speedometer
import StoreKit
import StoreKitTest
import XCTest

@MainActor
final class PurchaseManagerTests: XCTestCase {
    private var session: SKTestSession!
    private var purchaseManager: PurchaseManager!

    override func setUp() async throws {
        try await super.setUp()

        let configurationURL = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Speedometer/Supporting Files/StoreKit Configuration.storekit")
        session = try SKTestSession(contentsOf: configurationURL)
        session.resetToDefaultState()
        session.clearTransactions()
        session.disableDialogs = true

        purchaseManager = PurchaseManager()
        purchaseManager.start()
    }

    override func tearDown() async throws {
        session.clearTransactions()
        session = nil
        purchaseManager = nil

        try await super.tearDown()
    }

    func testProductsAreTheThreeTipsSortedByPrice() async throws {
        let products = try await purchaseManager.products()

        XCTAssertEqual(products.map(\.id), [
            "de.marcelkraus.speedometer.tip.incentive.small",
            "de.marcelkraus.speedometer.tip.incentive.medium",
            "de.marcelkraus.speedometer.tip.incentive.large",
        ])
        XCTAssertTrue(products.allSatisfy { $0.type == .nonConsumable })
    }

    func testPurchaseMakesSupporter() async throws {
        let product = try await firstProduct()

        let isPurchased = try await purchaseManager.purchase(product, in: windowScene())

        XCTAssertTrue(isPurchased)
        XCTAssertTrue(purchaseManager.isSupporter)
    }

    func testFailedPurchaseKeepsNonSupporter() async throws {
        let product = try await firstProduct()
        try await session.setSimulatedError(.generic(.unknown), forAPI: .purchase)

        do {
            _ = try await purchaseManager.purchase(product, in: windowScene())
            XCTFail("A failed purchase has to throw.")
        } catch {
            XCTAssertFalse(purchaseManager.isSupporter)
        }
    }

    func testPendingPurchaseKeepsNonSupporter() async throws {
        let product = try await firstProduct()
        session.askToBuyEnabled = true

        let isPurchased = try await purchaseManager.purchase(product, in: windowScene())

        XCTAssertFalse(isPurchased)
        XCTAssertFalse(purchaseManager.isSupporter)
    }

    func testRestoreMakesSupporterForEarlierTip() async throws {
        try await session.buyProduct(identifier: "de.marcelkraus.speedometer.tip.incentive.medium")

        let isSupporter = try await purchaseManager.restore()

        XCTAssertTrue(isSupporter)
    }

    func testRestoreWithoutTipKeepsNonSupporter() async throws {
        let isSupporter = try await purchaseManager.restore()

        XCTAssertFalse(isSupporter)
    }

    func testStartMakesSupporterForEarlierTip() async throws {
        try await session.buyProduct(identifier: "de.marcelkraus.speedometer.tip.incentive.large")
        // A tip from an earlier version is finished, so only the current entitlements report it.
        for await verificationResult in Transaction.unfinished {
            await verificationResult.unsafePayloadValue.finish()
        }

        let relaunchedPurchaseManager = PurchaseManager()
        relaunchedPurchaseManager.start()

        try await waitUntil { relaunchedPurchaseManager.isSupporter }
    }

    func testRefundEndsSupporter() async throws {
        let product = try await firstProduct()
        _ = try await purchaseManager.purchase(product, in: windowScene())
        XCTAssertTrue(purchaseManager.isSupporter)
        let transaction = try XCTUnwrap(session.allTransactions().first)

        try session.refundTransaction(identifier: UInt(transaction.identifier))

        try await waitUntil { self.purchaseManager.isSupporter == false }
    }
}

private extension PurchaseManagerTests {
    func firstProduct() async throws -> Product {
        let products = try await purchaseManager.products()

        return try XCTUnwrap(products.first)
    }

    func windowScene() throws -> UIWindowScene {
        try XCTUnwrap(UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.first)
    }

    /// The supporter status follows transaction updates asynchronously.
    func waitUntil(_ condition: @escaping () -> Bool, file: StaticString = #filePath, line: UInt = #line) async throws {
        for _ in 0 ..< 50 where condition() == false {
            try await Task.sleep(for: .milliseconds(100))
        }

        XCTAssertTrue(condition(), file: file, line: line)
    }
}
