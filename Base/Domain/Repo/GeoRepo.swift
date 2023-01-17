//
//  GeoLocationRepo.swift
//  Base
//
//  Created by BaoHoang on 29/11/2022.
//

import Foundation
import RxSwift

protocol GeoRepo {
    func getGeoCoordinate(param: [String: Any], model: [GeoCodingModel].Type) -> Observable<GeoCodingModel>
}
