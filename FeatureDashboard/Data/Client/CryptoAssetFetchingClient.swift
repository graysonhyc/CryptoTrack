//
//  CryptoAssetFetchingClient.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Alamofire
import Combine
import Foundation

enum CryptoAssetClientError: Error {
    case networkError(AFError)
    case unknown
}

protocol CryptoAssetFetchingClientAPI {

    /// Fetches the market asset information from CoinGekco (API v3)
    /// - Returns
    ///   - An `AnyPublisher` that emits an array of crypto asset response or error
    func fetchAssets() -> AnyPublisher<[CryptoAssetResponse], CryptoAssetClientError>
}

final class CryptoAssetFetchingClient: CryptoAssetFetchingClientAPI {
    func fetchAssets() -> AnyPublisher<[CryptoAssetResponse], CryptoAssetClientError> {
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: [CryptoAssetResponse].self)
            .flatMap { response -> AnyPublisher<[CryptoAssetResponse], CryptoAssetClientError> in
                if let error = response.error {
                    return Fail(error: .networkError(error)).eraseToAnyPublisher()
                }
                guard let value = response.value else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }
                return Just(value)
                    .setFailureType(to: CryptoAssetClientError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
