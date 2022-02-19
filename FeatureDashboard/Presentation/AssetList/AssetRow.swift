//
//  AssetRow.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 16/02/2022.
//

import SwiftUI

struct AssetRow: View {

    let asset: CryptoAsset

    var body: some View {
        HStack(alignment: .center, spacing: 15.0) {
            AsyncImage(
                url: asset.imageURL
            ) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 2.0) {
                Text(asset.name)
                    .font(.system(size: 13.0))
                    .fontWeight(.semibold)
                Text(asset.symbol.uppercased())
                    .font(.system(size: 12.0))
                    .fontWeight(.regular)
                    .opacity(0.8)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2.0) {
                Text("$\(String(format: "%.2f", asset.price))")
                    .font(.system(size: 13.0))
                    .fontWeight(.regular)
                    .opacity(0.8)
                Text("\(asset.btcExchangeRate) BTC")
                    .font(.system(size: 13.0))
                    .fontWeight(.regular)
                    .opacity(0.6)
            }
        }
        .padding(10)
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
