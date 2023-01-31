//
//  TopComicUC.swift
//  Base
//
//  Created by baohoang on 22/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

struct TopComicUC: TopComicRepo {
    
    func getTopManhua(param: [String : Any]) -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.topManhua(param: param))
            .asObservable()
            .catchErrReturnEmpty()
    }
    
    func getTopManhwa(param: [String : Any]) -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.topManhwa(param: param))
            .asObservable()
            .catchErrReturnEmpty()
    }
    
    func getHotComic(param: [String : Any]) -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.hot(param: param))
            .asObservable()
            .catchErrReturnEmpty()
    }
    
    func getTopManga(param: [String : Any]) -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.top(param: param))
            .asObservable()
            .catchErrReturnEmpty()
    }
    
    func getNominate() -> Observable<Document> {
        return Service.shared.request(input: TopComicRouter.nominate)
            .asObservable()
            .catchErrReturnEmpty()
    }
    
}
