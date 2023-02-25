//
//  CryptoAssetRepositoryAPI.swift
//  CryptoTrack

import Combine

enum CryptoAssetRepositoryError: Equatable, Error {
    case failedToFetch(String)
}

protocol CryptoAssetRepositoryAPI {

    /// Fetches crypto assets from the data/persistance layer.
    /// It will transform a response object o appropriate domain layer object
    /// - Returns:
    ///   - An `AnyPublisher` that emits an array of crypto assets or an error
    func fetchAsset() -> AnyPublisher<[CryptoAsset], CryptoAssetRepositoryError>
}
