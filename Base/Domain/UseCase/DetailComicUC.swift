//
//  DetailComicUC.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

struct DetailComicUC: DetailComicRepo {
    
    func getDetailComic(urlStrPath: String) -> Observable<Document> {
        Service.shared.request(input: ComicDetailRouter.detail(urlStrPath: urlStrPath))
            .asObservable()
            .catchErrReturnEmpty()
    }
    
    
}
