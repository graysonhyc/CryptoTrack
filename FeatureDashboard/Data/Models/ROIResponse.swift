//
//  ROIResponse.swift
//  BraveWalletHack (iOS)
//
//  Created by Grayson Ho on 19/02/2022.
//

import Foundation

struct ROIResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
        case times
        case currency
        case percentage
    }

    var times: Float?
    var currency: String?
    var percentage: Float?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        times = try container.decodeIfPresent(Float.self, forKey: .times)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        percentage = try container.decodeIfPresent(Float.self, forKey: .percentage)
    }
}
