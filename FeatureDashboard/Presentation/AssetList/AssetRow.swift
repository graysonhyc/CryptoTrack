//
//  AssetRow.swift
//  CryptoTrack

import SwiftUI

struct AssetRow: View {

    let asset: CryptoAsset

    var body: some View {
        HStack(alignment: .center, spacing: 15.0) {
            // todo: add image for crypto asset
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
                if asset.percentageChangeByDay >= 0 {
                    Text("+\(String(format: "%.2f", asset.percentageChangeByDay))%")
                        .foregroundColor(.green)
                        .font(.system(size: 13.0))
                        .fontWeight(.regular)
                } else {
                    Text("\(String(format: "%.2f", asset.percentageChangeByDay))%")
                        .foregroundColor(.red)
                        .font(.system(size: 13.0))
                        .fontWeight(.regular)
                }
                if let rate = asset.btcExchangeRate {
                    Text("\(rate) BTC")
                        .font(.system(size: 13.0))
                        .fontWeight(.regular)
                        .opacity(0.6)
                }
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
                percentageChangeByDay: 0.59,
                btcExchangeRate: 0.235
            )
        )
    }
}
