//
//  DashboardReducer.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import ComposableArchitecture

// MARK: - Type

enum DashboardAction: Equatable, BindableAction {
    case onAppear
    case fetchCryptoAsset
    case didFetchCryptoAsset(Result<[CryptoAsset], CryptoAssetRepositoryError>)
    case binding(BindingAction<DashboardState>)
}

enum DashboardCancellations {
    struct RefreshTimerId: Hashable {}
}

struct DashboardState: Equatable {
    @BindableState var searchText: String
    var cryptoAssets: [CryptoAsset]
    var filteredCryptoAssets: [CryptoAsset]

    init(
        searchText: String = "",
        cryptoAssets: [CryptoAsset] = []
    ) {
        self.searchText = searchText
        self.cryptoAssets = cryptoAssets
        filteredCryptoAssets = cryptoAssets
    }
}

struct DashboardEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    let assetRepository: CryptoAssetRepositoryAPI

    init(
        mainQueue: AnySchedulerOf<DispatchQueue>,
        assetRepository: CryptoAssetRepositoryAPI
    ) {
        self.mainQueue = mainQueue
        self.assetRepository = assetRepository
    }
}

let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    DashboardEnvironment
> { state, action, environment in
    switch action {
    case .onAppear:
        return Effect.timer(
            id: DashboardCancellations.RefreshTimerId(),
            every: 5,
            on: environment.mainQueue
        )
        .map { _ in
            .fetchCryptoAsset
        }
        .receive(on: environment.mainQueue)
        .eraseToEffect()

    case .fetchCryptoAsset:
        return environment
            .assetRepository
            .fetchAsset()
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map { result in
                switch result {
                case .success(let assets):
                    return .didFetchCryptoAsset(.success(assets))
                case .failure(let error):
                    return .didFetchCryptoAsset(.failure(error))
                }
            }

    case .didFetchCryptoAsset(let result):
        switch result {
        case .success(let assets):
            state.cryptoAssets = assets
        case .failure(let error):
            break
        }
        return .none

    case .binding(\.$searchText):
        if state.searchText.isEmpty {
            state.filteredCryptoAssets = state.cryptoAssets
        } else {
            state.filteredCryptoAssets = state.cryptoAssets.filter { $0.name.contains(state.searchText) }
        }
        return .none

    case .binding:
        return .none
    }
}
.binding()
