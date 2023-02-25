//
//  DashboardView.swift
//  CryptoTrack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

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
                        List {
                            Section(LocalizedString.AssetList.title) {
                                ForEach(viewStore.filteredCryptoAssets, id: \.symbol) {
                                    AssetRow(asset: $0)
                                }
                            }
                        }
                        .searchable(
                            text: viewStore.binding(\.$searchText),
                            placement: .navigationBarDrawer(displayMode: .always)
                        )
                        .refreshable { viewStore.send(.fetchCryptoAsset) }
                        .listStyle(.insetGrouped)
                        .listRowSeparator(.visible)
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
