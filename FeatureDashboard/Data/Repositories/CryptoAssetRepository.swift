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
        .map { [printAssets] (assets, priceResponse) in
            let assets = assets.map { asset -> CryptoAsset in
                if asset.symbol != "btc" {
                    let btcExchangeRate = Double(asset.currentPrice / priceResponse.price)
                    return asset.toDomain(btcExchangeRate: btcExchangeRate)
                }
                return asset.toDomain(btcExchangeRate: nil)
            }
            printAssets(assets)
            return assets
        }
        .mapError { error in
            .failedToFetch(error.localizedDescription)
        }
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
