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
        Publishers.Zip(
            client.fetchAssets(),
            client.fetchAssetPrice(name: "bitcoin", currency: "usd")
        )
        .map { (assets, priceResponse) in
            assets.map { asset in
                if asset.name != "bitcoin" {
                    let btcExchangeRate = Double(asset.currentPrice / priceResponse.price)
                    return asset.toDomain(btcExchangeRate: btcExchangeRate)
                }
                return asset.toDomain(btcExchangeRate: nil)
            }
        }
        .mapError { error in
            .failedToFetch(error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
