//
//  DashboardView.swift
//  BraveWalletHack (iOS)
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
                VStack {
                    List {
                        ForEach(viewStore.filteredCryptoAssets, id: \.symbol) {
                            AssetRow(asset: $0)
                        }
                    }
                    .searchable(text: viewStore.binding(\.$searchText))
                    .listStyle(.insetGrouped)
                    .listRowSeparator(.visible)
                }
                .navigationTitle(LocalizedString.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: searchButton)
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }

    private var searchButton: some View {
        Button(
            action: {
                // TODO: add view action
            },
            label: {
                Image(systemName: "magnifyingglass")
                    .frame(width: 24, height: 24)
            }
        )
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
