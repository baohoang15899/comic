//
//  WeatherRepo.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation
import RxSwift
import SwiftSoup

struct TopComicUc: TopComicRepo {

    func getHotComic(param: [String : Any]) -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.hot(param: param))
            .asObservable()
            .handleErr()
    }
    
    func getTopComic(param: [String : Any]) -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.top(param: param))
            .asObservable()
            .handleErr()
    }
    
    func getNominate() -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.nominate)
            .asObservable()
            .handleErr()
    }
    
}
