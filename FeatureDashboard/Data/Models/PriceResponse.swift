//
//  PriceResponse.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 19/02/2022.
//

import Foundation

struct CryptoAssetPriceResponse: Decodable {

    private struct CustomCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    let price: Float

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        let cryptoAssetKey = container.allKeys[0]
        let nestedContainer = try container.nestedContainer(keyedBy: CustomCodingKeys.self, forKey: cryptoAssetKey)
        let currencykey = nestedContainer.allKeys[0]
        price = try nestedContainer.decode(Float.self, forKey: CustomCodingKeys(stringValue: currencykey.stringValue)!)
    }
}
