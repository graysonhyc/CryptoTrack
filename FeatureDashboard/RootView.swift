//
//  RootView.swift
//  Shared

import SwiftUI

struct RootView: View {

    @State private var shouldOpenDashboard: Bool = false

    var body: some View {
        VStack(spacing: 100) {
            // todo: add logo
            Button(
                action: { shouldOpenDashboard.toggle() },
                label: {
                    Text(LocalizationConstants.RootView.enterApp)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                }
            )
            // todo: add view modifiers
        }
        // todo: add .sheet to show dashboard view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
