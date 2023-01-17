//
//  WindModel.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation

struct WindModel: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

enum WindKey : String, CodingKey {
    case speed
    case deg
    case gust
}


extension WindModel {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: WindKey.self)
        speed = try? container?.decodeIfPresent(Double.self, forKey: .speed)
        deg = try? container?.decodeIfPresent(Int.self, forKey: .deg)
        gust = try? container?.decodeIfPresent(Double.self, forKey: .gust)
    }
}
