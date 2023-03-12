//
//  CryptoAssetFetchingClient.swift
//  CryptoTrack

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
        // todo: fetch assets from the api
        Just([])
            .setFailureType(to: CryptoAssetClientError.self)
            .eraseToAnyPublisher()
    }

    func fetchAssetPrice(name: String, currency: String) -> AnyPublisher<CryptoAssetPriceResponse, CryptoAssetClientError> {
        // todo: fetch asset price from the api
        Fail(error: CryptoAssetClientError.unknown)
            .eraseToAnyPublisher()
    }
}
