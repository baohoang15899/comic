//
//  SearchUC.swift
//  Base
//
//  Created by BaoHoang on 27/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

struct SearchUC: SearchRepo {
    
    func getSearchComic(keyword: String) -> Observable<Document> {
        return Service.shared.request(input: SearchRouter.search(keyword: keyword))
            .asObservable()
            .catchErrReturnEmpty()
    }
    
}
