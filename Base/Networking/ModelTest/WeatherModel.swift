//
//  WeatherModel.swift
//  Base
//
//  Created by BaoHoang on 29/11/2022.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [WeatherInfoModel]?
    let main: WeatherMainAttrModel?
    let visibility: Int?
    let wind: WindModel?
    let dateTime: Int?
    let fullDate: String?
    let clouds: CloudsModel?
    let rain: RainModel?
}

enum WeatherKey: String, CodingKey {
    case weather
    case main
    case visibility
    case wind
    case clouds
    case rain
    case dateTime = "dt"
    case dateTimeString = "dt_txt"
}

extension WeatherModel {
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: WeatherKey.self)
        weather = try? container?.decodeIfPresent([WeatherInfoModel].self, forKey: .weather)
        main = try? container?.decodeIfPresent(WeatherMainAttrModel.self, forKey: .main)
        visibility = try? container?.decodeIfPresent(Int.self, forKey: .visibility)
        wind = try? container?.decodeIfPresent(WindModel.self, forKey: .wind)
        clouds = try? container?.decodeIfPresent(CloudsModel.self, forKey: .clouds)
        rain = try? container?.decodeIfPresent(RainModel.self, forKey: .rain)
        dateTime = try? container?.decodeIfPresent(Int.self, forKey: .dateTime)
        fullDate = try? container?.decodeIfPresent(String.self, forKey: .dateTimeString)
    }
}
