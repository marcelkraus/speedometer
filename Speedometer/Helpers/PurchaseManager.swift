import StoreKit

@MainActor
final class PurchaseManager {
    private static let productIDs = [
        "de.marcelkraus.speedometer.tip.incentive.large",
        "de.marcelkraus.speedometer.tip.incentive.medium",
        "de.marcelkraus.speedometer.tip.incentive.small",
    ]

    private(set) var isSupporter = false

    private var transactionUpdatesTask: Task<Void, Never>?

    nonisolated init() {
        // Intentionally left blank.
    }

    func start() {
        guard transactionUpdatesTask == nil else {
            return
        }

        transactionUpdatesTask = Task { [weak self] in
            for await verificationResult in Transaction.updates {
                guard case let .verified(transaction) = verificationResult else {
                    continue
                }

                await self?.complete(transaction)
            }
        }

        Task {
            isSupporter = await Self.hasEntitlement()
        }
    }

    func products() async throws -> [Product] {
        try await Product.products(for: Self.productIDs).sorted { $0.price < $1.price }
    }

    func purchase(_ product: Product, in scene: UIScene) async throws -> Bool {
        let result = try await product.purchase(confirmIn: scene)
        guard case let .success(verificationResult) = result, case let .verified(transaction) = verificationResult else {
            return false
        }

        await complete(transaction)

        return true
    }

    func restore() async throws -> Bool {
        try await AppStore.sync()
        isSupporter = await Self.hasEntitlement()

        return isSupporter
    }
}

private extension PurchaseManager {
    func complete(_ transaction: Transaction) async {
        await transaction.finish()
        isSupporter = await Self.hasEntitlement()
    }

    /// Every tip is a non-consumable, so any current entitlement marks a supporter.
    static func hasEntitlement() async -> Bool {
        for await verificationResult in Transaction.currentEntitlements {
            if case let .verified(transaction) = verificationResult, transaction.revocationDate == nil {
                return true
            }
        }

        return false
    }
}
