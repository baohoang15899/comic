//
//  RepoFactory.swift
//  Base
//
//  Created by BaoHoang on 29/11/2022.
//

import Foundation

struct RepoFactory {
    
    static func getGeoRepo() -> GeoRepo {
        return GeoUC()
    }
    
    static func TopComicRepo() -> TopComicRepo {
        return TopComicUc()
    }
    
}
