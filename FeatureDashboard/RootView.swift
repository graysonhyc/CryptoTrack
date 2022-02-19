//
//  ContentView.swift
//  Shared
//
//  Created by Grayson Ho on 16/02/2022.
//

import SwiftUI

struct RootView: View {

    @State private var shouldOpenDashboard: Bool = false

    var body: some View {
        Button("Tap to open dashboard") {
            shouldOpenDashboard.toggle()
        }
        .sheet(isPresented: $shouldOpenDashboard) {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
