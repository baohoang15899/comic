//
//  LocalName.swift
//  Base
//
//  Created by BaoHoang on 29/11/2022.
//

import Foundation

struct localNames: Codable {
    let vi: String?
}

enum localNamesKey: String, CodingKey {
    case vi
}

extension localNames {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: localNamesKey.self)
        vi = try? container?.decodeIfPresent(String.self, forKey: .vi)
    }
}
