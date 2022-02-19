//
//  DashboardReducer.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import ComposableArchitecture

// MARK: - Type

enum DashboardAction: Equatable, BindableAction {
    case binding(BindingAction<DashboardState>)
}

struct DashboardState: Equatable {
    @BindableState var searchText: String = ""
    var cryptoAssets: [CryptoAsset] = []
    var filteredCryptoAssets: [CryptoAsset] = []
}

struct DashboardEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>

    init(mainQueue: AnySchedulerOf<DispatchQueue>) {
        self.mainQueue = mainQueue
    }
}

let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    DashboardEnvironment
> { state, action, environment in
    switch action {
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
