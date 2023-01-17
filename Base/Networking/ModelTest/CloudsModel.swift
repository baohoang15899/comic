//
//  CloudsModel.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation

struct CloudsModel: Codable {
    let all: Int?
}

enum CloudsKey : String, CodingKey {
    case all
}


extension CloudsModel {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CloudsKey.self)
        all = try? container?.decodeIfPresent(Int.self, forKey: .all)
    }
}
