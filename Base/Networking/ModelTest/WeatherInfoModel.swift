//
//  WeatherInfo.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation

struct WeatherInfoModel: Codable {
    let id: Int?
    let main: String?
    let des: String?
    let icon: String?
}

enum WeatherInfoKey : String, CodingKey {
    case id
    case main
    case des = "description"
    case icon
}

extension WeatherInfoModel {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: WeatherInfoKey.self)
        id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        main = try? container?.decodeIfPresent(String.self, forKey: .main)
        des = try? container?.decodeIfPresent(String.self, forKey: .des)
        icon = try? container?.decodeIfPresent(String.self, forKey: .icon)
    }
}
