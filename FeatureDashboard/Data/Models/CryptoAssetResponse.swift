//
//  CryptoAssetResponse.swift
//  CryptoTrack (iOS)
//
//  Created by Grayson Ho on 19/02/2022.
//

import Foundation

struct CryptoAssetResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case priceChangePercentage24h = "price_change_percentage_24h"
        case symbol
        case currentPrice = "current_price"
        case image
        case name
    }

    var priceChangePercentage24h: Float
    var symbol: String
    var currentPrice: Float
    var image: String?
    var name: String


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        priceChangePercentage24h = try container.decode(Float.self, forKey: .priceChangePercentage24h)
        symbol = try container.decode(String.self, forKey: .symbol)
        currentPrice = try container.decode(Float.self, forKey: .currentPrice)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
    }

    func toDomain(btcExchangeRate: Double?) -> CryptoAsset {
        CryptoAsset(
            imageURL: URL(string: image ?? ""),
            name: name,
            symbol: symbol,
            price: Double(currentPrice),
            percentageChangeByDay: Double(priceChangePercentage24h),
            btcExchangeRate: btcExchangeRate
        )
    }
}
