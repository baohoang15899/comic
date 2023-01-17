//
//  RainModel.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation

struct RainModel: Codable {
    let oneHour: Double?
    let threeHour: Double?
}

enum RainKey : String, CodingKey {
    case oneHour = "1h"
    case threeHour = "3h"
}


extension RainModel {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: RainKey.self)
        oneHour = try? container?.decodeIfPresent(Double.self, forKey: .oneHour)
        threeHour = try? container?.decodeIfPresent(Double.self, forKey: .threeHour)
    }
}
