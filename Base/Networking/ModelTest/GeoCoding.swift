//
//  GeoCoding.swift
//  Base
//
//  Created by BaoHoang on 29/11/2022.
//

import Foundation

struct GeoCodingModel: Codable {
    let lat: Double?
    let lon: Double?
    let name: String?
    let country: String?
    let cityName: localNames?
}

enum GeoCodingKey : String, CodingKey {
    case lat
    case lon
    case name
    case country
    case cityName = "local_names"
}

extension GeoCodingModel {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: GeoCodingKey.self)
        lat = try? container?.decodeIfPresent(Double.self, forKey: .lat)
        lon = try? container?.decodeIfPresent(Double.self, forKey: .lon)
        name = try? container?.decodeIfPresent(String.self, forKey: .name)
        country = try? container?.decodeIfPresent(String.self, forKey: .country)
        cityName = try? container?.decodeIfPresent(localNames.self, forKey: .cityName)
    }
}
