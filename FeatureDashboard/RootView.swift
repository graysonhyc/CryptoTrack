//
//  ContentView.swift
//  Shared
//
//  Created by Grayson Ho on 16/02/2022.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        DashboardView(
            store: .init(
                initialState: .init(
                    cryptoAssets: [
                        CryptoAsset(
                            imageURL: nil,
                            name: "Bitcoin",
                            symbol: "BTC",
                            price: 52255.45,
                            btcExchangeRate: 0.235
                        ),
                        CryptoAsset(
                            imageURL: nil,
                            name: "Bitcoin",
                            symbol: "BTC",
                            price: 52255.45,
                            btcExchangeRate: 0.235
                        ),
                        CryptoAsset(
                            imageURL: nil,
                            name: "Bitcoin",
                            symbol: "BTC",
                            price: 52255.45,
                            btcExchangeRate: 0.235
                        )
                    ]
                ),
                reducer: dashboardReducer,
                environment: .init(mainQueue: .main)
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
