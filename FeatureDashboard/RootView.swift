//
//  RootView.swift
//  Shared
//
//  Created by Grayson Ho on 16/02/2022.
//

import SwiftUI

struct RootView: View {

    @State private var shouldOpenDashboard: Bool = false

    var body: some View {
        VStack(spacing: 100) {
            Image("logo")
                .resizable()
                .frame(width: 128, height: 128)
            Button(
                action: { shouldOpenDashboard.toggle() },
                label: {
                    Text(LocalizationConstants.RootView.enterApp)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                }
            )
            .padding(.horizontal, 24)
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
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
