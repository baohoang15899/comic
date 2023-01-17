//
//  Constants.swift
//  Base
//
//  Created by BaoHoang on 14/10/2022.
//

import Foundation

struct NetworkConstant {
    static let failed = "false"
    static let success = "Success."
}

struct BaseApiRequest {
    static let url = "https://www.nettruyenking.com/"
    static let apiKey = "96c4a4ab28241e28b1db73d5baf8f43f"
}

struct GeoCodingURL {
    static let getCoordinate = "/geo/1.0/direct"
}

struct nettruyenPath {
    static let hotPath = "hot"
    static let adult = "tim-truyen/truong-thanh"
}

struct WeatherCaculate {
    
    static func kelvinToCelsius(K: Double) -> String {
        return String(format: "%.0f", K - 273.15)
    }
    
    static func kilometerPerHourWindSpeed(value: Double) -> Int {
        return Int(value * 3.6)
    }
    
    static func visibilityKilometer(value: Int) -> Double {
        return Double(value / 100)
    }
    
}
