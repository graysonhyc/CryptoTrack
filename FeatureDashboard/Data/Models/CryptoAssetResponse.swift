//
//  CryptoAssetResponse.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 19/02/2022.
//

import Foundation

struct CryptoAssetResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case circulatingSupply = "circulating_supply"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case ath
        case symbol
        case atlChangePercentage = "atl_change_percentage"
        case marketCapRank = "market_cap_rank"
        case id
        case low24h = "low_24h"
        case marketCap = "market_cap"
        case athDate = "ath_date"
        case priceChange24h = "price_change_24h"
        case totalVolume = "total_volume"
        case marketCapChange24h = "market_cap_change_24h"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case lastUpdated = "last_updated"
        case currentPrice = "current_price"
        case atl
        case high24h = "high_24h"
        case maxSupply = "max_supply"
        case atlDate = "atl_date"
        case athChangePercentage = "ath_change_percentage"
        case image
        case name
        case roi
        case totalSupply = "total_supply"
    }

    var circulatingSupply: Float?
    var priceChangePercentage24h: Float?
    var ath: Float?
    var symbol: String?
    var atlChangePercentage: Float?
    var marketCapRank: Int?
    var id: String?
    var low24h: Float?
    var marketCap: Int?
    var athDate: String?
    var priceChange24h: Float?
    var totalVolume: Int?
    var marketCapChange24h: Float?
    var fullyDilutedValuation: Int?
    var marketCapChangePercentage24h: Float?
    var lastUpdated: String?
    var currentPrice: Float?
    var atl: Float?
    var high24h: Float?
    var maxSupply: Int?
    var atlDate: String?
    var athChangePercentage: Float?
    var image: String?
    var name: String?
    var roi: ROIResponse?
    var totalSupply: Int?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        circulatingSupply = try container.decodeIfPresent(Float.self, forKey: .circulatingSupply)
        priceChangePercentage24h = try container.decodeIfPresent(Float.self, forKey: .priceChangePercentage24h)
        ath = try container.decodeIfPresent(Float.self, forKey: .ath)
        symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        atlChangePercentage = try container.decodeIfPresent(Float.self, forKey: .atlChangePercentage)
        marketCapRank = try container.decodeIfPresent(Int.self, forKey: .marketCapRank)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        low24h = try container.decodeIfPresent(Float.self, forKey: .low24h)
        marketCap = try container.decodeIfPresent(Int.self, forKey: .marketCap)
        athDate = try container.decodeIfPresent(String.self, forKey: .athDate)
        priceChange24h = try container.decodeIfPresent(Float.self, forKey: .priceChange24h)
        totalVolume = try container.decodeIfPresent(Int.self, forKey: .totalVolume)
        marketCapChange24h = try container.decodeIfPresent(Float.self, forKey: .marketCapChange24h)
        fullyDilutedValuation = try container.decodeIfPresent(Int.self, forKey: .fullyDilutedValuation)
        marketCapChangePercentage24h = try container.decodeIfPresent(Float.self, forKey: .marketCapChangePercentage24h)
        lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
        currentPrice = try container.decodeIfPresent(Float.self, forKey: .currentPrice)
        atl = try container.decodeIfPresent(Float.self, forKey: .atl)
        high24h = try container.decodeIfPresent(Float.self, forKey: .high24h)
        maxSupply = try container.decodeIfPresent(Int.self, forKey: .maxSupply)
        atlDate = try container.decodeIfPresent(String.self, forKey: .atlDate)
        athChangePercentage = try container.decodeIfPresent(Float.self, forKey: .athChangePercentage)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        roi = try container.decodeIfPresent(ROIResponse.self, forKey: .roi)
        totalSupply = try container.decodeIfPresent(Int.self, forKey: .totalSupply)
    }

    func toDomain() -> CryptoAsset {
        CryptoAsset(
            imageURL: URL(string: image ?? ""),
            name: name ?? "",
            symbol: symbol ?? "",
            price: Double(currentPrice ?? 0.0),
            btcExchangeRate: 0.0
        )
    }
}
