//
//  CryptoAssetRepository.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Combine

final class CryptoAssetRepository: CryptoAssetRepositoryAPI {

    // MARK: - Properties

    private let client: CryptoAssetFetchingClientAPI

    // MARK: - Setup

    init(client: CryptoAssetFetchingClientAPI = CryptoAssetFetchingClient()) {
        self.client = client
    }

    // MARK: - API

    func fetchAsset() -> AnyPublisher<[CryptoAsset], CryptoAssetRepositoryError> {
        client
            .fetchAssets()
            .map { $0.map { $0.toDomain() } }
            .mapError { _ in .clientError }
            .eraseToAnyPublisher()
    }
}
