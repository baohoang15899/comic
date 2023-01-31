//
//  GeoLocationUC.swift
//  Base
//
//  Created by BaoHoang on 29/11/2022.
//

import Foundation
import RxSwift

struct GeoUC: GeoRepo {
  
    func getGeoCoordinate(param: [String : Any], model: [GeoCodingModel].Type) -> Observable<GeoCodingModel> {
        return Service.shared.requestArray(input: GeoLocationRouter.geocoding(param: param), responseType: model)
            .asObservable()
            .catchErrReturnEmpty()
    }
    
}

