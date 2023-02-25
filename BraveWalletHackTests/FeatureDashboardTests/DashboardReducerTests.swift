//
//  DashboardReducerTests.swift
//  Tests iOS
//
//  Created by Grayson Ho on 19/02/2022.
//

@testable import CryptoTrack
import ComposableArchitecture
import XCTest

final class DashboardReducerTests: XCTestCase {

    private var mockMainQueue: TestSchedulerOf<DispatchQueue>!
    private var testStore: TestStore<
        DashboardState,
        DashboardState,
        DashboardAction,
        DashboardAction,
        DashboardEnvironment
    >!
    private var expectedCryptoAssets = [
        CryptoAsset(
            imageURL: URL(string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579")!,
            name: "Bitcoin",
            symbol: "btc",
            price: 40155.0,
            percentageChangeByDay: -0.15452000498771667,
            btcExchangeRate: nil
        ),
        CryptoAsset(
            imageURL: URL(string: "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880")!,
            name: "Ethereum",
            symbol: "eth",
            price: 2757.4599609375,
            percentageChangeByDay: -1.3040800094604492,
            btcExchangeRate: 0.06867723912000656
        )
    ]

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMainQueue = DispatchQueue.test
        testStore = TestStore(
            initialState: .init(),
            reducer: dashboardReducer,
            environment: DashboardEnvironment(
                mainQueue: mockMainQueue.eraseToAnyScheduler(),
                assetRepository: CryptoAssetRepository(
                    client: MockCryptoAssetFetchingClient()
                )
            )
        )
    }

    override func tearDownWithError() throws {
        mockMainQueue = nil
        testStore = nil
        try super.tearDownWithError()
    }

    func testFetchShouldGiveExpectedAssets() {
        testStore.send(.fetchCryptoAsset)
        mockMainQueue.advance()
        testStore.receive(.didFetchCryptoAsset(.success(expectedCryptoAssets))) { state in
            state.cryptoAssets = self.expectedCryptoAssets
        }
        testStore.receive(.set(\.$searchText, "")) { state in
            state.filteredCryptoAssets = self.expectedCryptoAssets
        }
    }
}
