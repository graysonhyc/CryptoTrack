//
//  CryptoAssetFetchingClient.swift
//  CryptoTrack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Alamofire
import Combine
import Foundation

enum CryptoAssetClientError: Error {
    case invalidStatusCode(code: Int)
    case alamofire(AFError)
    case unknown
}

protocol CryptoAssetFetchingClientAPI {

    /// Fetches the market asset information (in usd) from CoinGekco (API v3)
    /// - Returns
    ///   - An `AnyPublisher` that emits an array of crypto asset response or error
    func fetchAssets() -> AnyPublisher<[CryptoAssetResponse], CryptoAssetClientError>

    /// Fetches a single market asset information from CoinGekco (API v3)
    /// - Parameters:
    ///   - name: crypto asset name
    ///   - currency: currency type
    /// - Returns
    ///   - An `AnyPublisher` that emits an crypto asset price response or error
    func fetchAssetPrice(name: String, currency: String) -> AnyPublisher<CryptoAssetPriceResponse, CryptoAssetClientError>
}

final class CryptoAssetFetchingClient: CryptoAssetFetchingClientAPI {

    // MARK: - API

    func fetchAssets() -> AnyPublisher<[CryptoAssetResponse], CryptoAssetClientError> {
        let pathComponent = "coins/markets"
        let queryItems: [URLQueryItem] = [
            URLQueryItem(
                name: "vs_currency",
                value: "usd"
            ),
            URLQueryItem(
                name: "order",
                value: "market_cap_desc"
            )
        ]
        var urlComponent = URLComponents(string: APIConstants.Host.coinGekco + pathComponent)
        urlComponent?.queryItems = queryItems
        return AF.request(urlComponent!.url!.absoluteString, method: .get)
            .validate()
            .publishDecodable(type: [CryptoAssetResponse].self)
            .flatMap { response -> AnyPublisher<[CryptoAssetResponse], CryptoAssetClientError> in
                if let statusCode = response.response?.statusCode {
                    guard statusCode == 200 else {
                        return Fail(error: .invalidStatusCode(code: statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                if let error = response.error {
                    return Fail(error: .alamofire(error))
                        .eraseToAnyPublisher()
                }
                guard let value = response.value else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                return Just(value)
                    .setFailureType(to: CryptoAssetClientError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func fetchAssetPrice(name: String, currency: String) -> AnyPublisher<CryptoAssetPriceResponse, CryptoAssetClientError> {
        let pathComponent = "simple/price"
        let queryItems: [URLQueryItem] = [
            URLQueryItem(
                name: "vs_currencies",
                value: currency
            ),
            URLQueryItem(
                name: "ids",
                value: name
            )
        ]
        var urlComponent = URLComponents(string: APIConstants.Host.coinGekco + pathComponent)
        urlComponent?.queryItems = queryItems
        return AF.request(urlComponent!.url!.absoluteString, method: .get)
            .validate()
            .publishDecodable(type: CryptoAssetPriceResponse.self)
            .flatMap { response -> AnyPublisher<CryptoAssetPriceResponse, CryptoAssetClientError> in
                if let statusCode = response.response?.statusCode {
                    guard statusCode == 200 else {
                        return Fail(error: .invalidStatusCode(code: statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                if let error = response.error {
                    return Fail(error: .alamofire(error))
                        .eraseToAnyPublisher()
                }
                guard let value = response.value else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                return Just(value)
                    .setFailureType(to: CryptoAssetClientError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
