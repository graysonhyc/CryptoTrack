//
//  LocalizationConstants.swift
//  CryptoTrack

import Foundation

enum LocalizationConstants {
    enum RootView {
        static let enterApp = NSLocalizedString(
            "Enter Crypto Tracker",
            comment: "Enter app string"
        )
    }
    enum DashboardView {
        static let navigationTitle = NSLocalizedString(
            "Crypto",
            comment: "Navigation title for the crypto dashboard screen"
        )
        enum AssetList {
            static let title = NSLocalizedString(
                "Assets",
                comment: "Title for the asset list view"
            )
        }
    }
}
