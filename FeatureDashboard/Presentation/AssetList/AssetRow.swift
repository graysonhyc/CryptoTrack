//
//  AssetRow.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import SwiftUI

struct AssetRow: View {

    private let asset: CryptoAsset

    init(asset: CryptoAsset) {
        self.asset = asset
    }

    var body: some View {
        HStack(alignment: .center, spacing: 15.0) {
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 2.0) {
                Text(asset.name)
                    .font(.system(size: 13.0))
                    .fontWeight(.semibold)
                Text(asset.symbol)
                    .font(.system(size: 12.0))
                    .fontWeight(.regular)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2.0) {
                Text("$\(String(format: "%.2f", asset.price))")
                    .font(.system(size: 13.0))
                    .fontWeight(.regular)
                Text("\(asset.btcExchangeRate) BTC")
                    .font(.system(size: 13.0))
                    .fontWeight(.regular)
            }
        }
        .padding(15)
    }
}

struct AssetRow_Previews: PreviewProvider {

    static var previews: some View {
        AssetRow(
            asset: CryptoAsset(
                imageURL: nil,
                name: "Bitcoin",
                symbol: "BTC",
                price: 52255.45,
                btcExchangeRate: 0.235
            )
        )
    }
}
