//
//  WeatherMainAttrModel.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation

struct WeatherMainAttrModel: Codable {
    let temp: Double?
    let feelsLike: Double?
    let pressure: Double?
    let tempMin: Double?
    let tempMax: Double?
    let humidity: Double?
    let seaLevel: Double?
    let groundLevel: Double?
}

enum WeatherMainAttrKey : String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case pressure
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case humidity
    case seaLevel = "sea_level"
    case groundLevel = "grnd_level"
}


extension WeatherMainAttrModel {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: WeatherMainAttrKey.self)
        temp = try? container?.decodeIfPresent(Double.self, forKey: .temp)
        feelsLike = try? container?.decodeIfPresent(Double.self, forKey: .feelsLike)
        pressure = try? container?.decodeIfPresent(Double.self, forKey: .pressure)
        tempMin = try? container?.decodeIfPresent(Double.self, forKey: .tempMin)
        tempMax = try? container?.decodeIfPresent(Double.self, forKey: .tempMax)
        humidity = try? container?.decodeIfPresent(Double.self, forKey: .humidity)
        seaLevel = try? container?.decodeIfPresent(Double.self, forKey: .seaLevel)
        groundLevel = try? container?.decodeIfPresent(Double.self, forKey: .groundLevel)
    }
}
