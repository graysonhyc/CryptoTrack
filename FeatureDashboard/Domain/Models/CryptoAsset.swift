//
//  CryptoAsset.swift
//  CryptoTrack

import Foundation

struct CryptoAsset: Equatable {
    let imageURL: URL?
    let name: String
    let symbol: String
    let price: Double
    let percentageChangeByDay: Double
    let btcExchangeRate: Double?
}
