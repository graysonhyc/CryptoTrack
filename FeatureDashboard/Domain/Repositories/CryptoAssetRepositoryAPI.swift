//
//  CryptoAssetRepositoryAPI.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Combine

enum CryptoAssetRepositoryError: Error {
}

protocol CryptoAssetRepositoryAPI {
    func fetchAsset() -> AnyPublisher<CryptoAsset, CryptoAssetRepositoryError>
}
