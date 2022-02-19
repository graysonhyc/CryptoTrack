//
//  MockFetchingClient.swift
//  Tests iOS
//
//  Created by Grayson Ho on 19/02/2022.
//

@testable import BraveWalletHack
import Combine
import Foundation

final class MockCryptoAssetFetchingClient: CryptoAssetFetchingClientAPI {

    var expectedPriceResponse: CryptoAssetPriceResponse {
        let jsonData = """
        {
            "bitcoin": {
                "usd": 40151
            }
        }
        """.data(using: .utf8)!
        let decoded = try! JSONDecoder().decode(CryptoAssetPriceResponse.self, from: jsonData)
        return decoded
    }

    var expectedAssetsResponse: [CryptoAssetResponse] {
        let jsonData = """
        [
          {
            "id": "bitcoin",
            "symbol": "btc",
            "name": "Bitcoin",
            "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
            "current_price": 40155,
            "market_cap": 761461545809,
            "market_cap_rank": 1,
            "fully_diluted_valuation": 843259215622,
            "total_volume": 12665267663,
            "high_24h": 40442,
            "low_24h": 39763,
            "price_change_24h": -62.145713352031,
            "price_change_percentage_24h": -0.15452,
            "market_cap_change_24h": -176308228.2833252,
            "market_cap_change_percentage_24h": -0.02315,
            "circulating_supply": 18962962,
            "total_supply": 21000000,
            "max_supply": 21000000,
            "ath": 69045,
            "ath_change_percentage": -41.87638,
            "ath_date": "2021-11-10T14:24:11.849Z",
            "atl": 67.81,
            "atl_change_percentage": 59082.87858,
            "atl_date": "2013-07-06T00:00:00.000Z",
            "roi": null,
            "last_updated": "2022-02-19T18:49:36.220Z"
          },
          {
            "id": "ethereum",
            "symbol": "eth",
            "name": "Ethereum",
            "image": "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
            "current_price": 2757.46,
            "market_cap": 330018709468,
            "market_cap_rank": 2,
            "fully_diluted_valuation": null,
            "total_volume": 11039653500,
            "high_24h": 2830.09,
            "low_24h": 2711.7,
            "price_change_24h": -36.434735936647,
            "price_change_percentage_24h": -1.30408,
            "market_cap_change_24h": -3728943588.215393,
            "market_cap_change_percentage_24h": -1.11729,
            "circulating_supply": 119647902.4365,
            "total_supply": null,
            "max_supply": null,
            "ath": 4878.26,
            "ath_change_percentage": -43.53452,
            "ath_date": "2021-11-10T14:24:19.604Z",
            "atl": 0.432979,
            "atl_change_percentage": 636081.90768,
            "atl_date": "2015-10-20T00:00:00.000Z",
            "roi": {
              "times": 90.83215060951521,
              "currency": "btc",
              "percentage": 9083.215060951521
            },
            "last_updated": "2022-02-19T18:50:31.616Z"
          }
        ]
        """.data(using: .utf8)!
        let decoded = try! JSONDecoder().decode([CryptoAssetResponse].self, from: jsonData)
        return decoded
    }

    func fetchAssetPrice(name: String, currency: String) -> AnyPublisher<CryptoAssetPriceResponse, CryptoAssetClientError> {
        Just(expectedPriceResponse)
            .setFailureType(to: CryptoAssetClientError.self)
            .eraseToAnyPublisher()
    }

    func fetchAssets() -> AnyPublisher<[CryptoAssetResponse], CryptoAssetClientError> {
        Just(expectedAssetsResponse)
            .setFailureType(to: CryptoAssetClientError.self)
            .eraseToAnyPublisher()
    }
}
