//
//  DashboardReducer.swift
//  CryptoTrack

import ComposableArchitecture

// MARK: - Type

enum DashboardAction: Equatable, BindableAction {
    case onAppear
    case onDisappear
    case fetchCryptoAsset
    case didFetchCryptoAsset(Result<[CryptoAsset], CryptoAssetRepositoryError>)
    case fabButtonTapped
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
        return .merge(
            Effect(value: .fetchCryptoAsset)
            // todo: implement periodic fetching
        )

    case .onDisappear:
        return .cancel(id: DashboardCancellations.RefreshTimerId())

    case .fetchCryptoAsset:
        // todo: implement fetch crypto asset
        return .none

    case .didFetchCryptoAsset(let result):
        switch result {
        case .success(let assets):
            state.cryptoAssets = assets
            return Effect(value: .set(\.$searchText, state.searchText))
        case .failure(let error):
            break
        }
        return .none

    case .fabButtonTapped:
        print("fabbedButtonTapped - perform action")
        return .none

    case .binding(\.$searchText):
        // todo: implement search by text
        return .none

    case .binding:
        return .none
    }
}
.binding()
