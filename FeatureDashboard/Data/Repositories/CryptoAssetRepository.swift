//
//  CryptoAssetRepository.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Combine

final class CryptoAssetRepository: CryptoAssetRepositoryAPI {
    func fetchAsset() -> AnyPublisher<CryptoAsset, CryptoAssetRepositoryError> {
        fatalError("not implemented")
    }
}
