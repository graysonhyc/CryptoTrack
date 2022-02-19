//
//  CryptoAssetRepositoryAPI.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Combine

enum CryptoAssetRepositoryError: Error {
    case clientError
}

protocol CryptoAssetRepositoryAPI {

    /// Fetches crypto assets from the data/persistance layer.
    /// It will transform a response object o appropriate domain layer object
    /// - Returns:
    ///   - An `AnyPublisher` that emits an array of crypto assets or an error
    func fetchAsset() -> AnyPublisher<[CryptoAsset], CryptoAssetRepositoryError>
}
