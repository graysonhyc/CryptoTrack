//
//  CryptoAsset.swift
//  CryptoTrack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Foundation

struct CryptoAsset: Equatable {
    let imageURL: URL?
    let name: String
    let symbol: String
    let price: Double
    let percentageChangeByDay: Double
    let btcExchangeRate: Double?
}
