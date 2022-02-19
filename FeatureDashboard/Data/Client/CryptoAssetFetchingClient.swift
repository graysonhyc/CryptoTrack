//
//  CryptoAssetFetchingClient.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import Alamofire
import Combine

enum CryptoAssetClientError: Error {
}

protocol CryptoAssetFetchingClientAPI {
    func fetchAssets() -> AnyPublisher<CryptoAssetResponse, CryptoAssetClientError>
}

final class CryptoAssetFetchingClient: CryptoAssetFetchingClientAPI {
    func fetchAssets() -> AnyPublisher<CryptoAssetResponse, CryptoAssetClientError> {
        fatalError("not implemented")
    }
}
