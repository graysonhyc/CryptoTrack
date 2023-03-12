//
//  CryptoAssetRepository.swift
//  CryptoTrack

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
        // todo: fetch assets from the network client
        Just([])
            .setFailureType(to: CryptoAssetRepositoryError.self)
            .eraseToAnyPublisher()
    }
}

private extension CryptoAssetRepository {

    func printAssets(_ assets: [CryptoAsset])  {
        assets.forEach {
            print("\($0.name) - \($0.price) - \($0.btcExchangeRate ?? 1.0)")
        }
    }
}
