//
//  DashboardReducer.swift
//  CryptoTrack

import ComposableArchitecture

// MARK: - Type

enum DashboardAction: Equatable, BindableAction {
    case binding(BindingAction<DashboardState>)
    // todo: add other required actions
}

enum DashboardCancellations {
    struct RefreshTimerId: Hashable {}
}

struct DashboardState: Equatable {
    // todo: add properties for the state
}

struct DashboardEnvironment {
    // todo: add dependencies for the environment
}

let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    DashboardEnvironment
> { state, action, environment in
    switch action {
    case .binding:
        return .none

    // todo: add other reducer actions handling
    }
}
.binding()
