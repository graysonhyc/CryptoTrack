//
//  DashboardView.swift
//  CryptoTrack

import ComposableArchitecture
import SwiftUI

struct DashboardView: View {

    private typealias LocalizedString = LocalizationConstants.DashboardView

    private let store: Store<DashboardState, DashboardAction>

    init(store: Store<DashboardState, DashboardAction>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ZStack(alignment: .bottom) {
                    VStack {
                        // todo: add a list of crypto assets
                    }
                }
                .navigationTitle(LocalizedString.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear { viewStore.send(.onAppear) }
                .onDisappear { viewStore.send(.onDisappear) }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            store: .init(
                initialState: .init(),
                reducer: dashboardReducer,
                environment: .init(
                    mainQueue: .main,
                    assetRepository: CryptoAssetRepository()
                )
            )
        )
    }
}
