//
//  ChapterDetailUC.swift
//  Base
//
//  Created by baohoang on 23/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

struct ChapterDetailUC: ChapterDetailRepo {
    
    func getChapterImg(urlStrPath: String) -> Observable<Data> {
        return Service.shared.requestImage(input: ChapterDetailRouter.getChapterImg(url: urlStrPath))
            .asObservable()
            .handleErr()
    }
    
    func getDetailChapter(urlStrPath: String) -> Observable<Document> {
        return Service.shared.request(input: ChapterDetailRouter.getChapter(url: urlStrPath))
            .asObservable()
            .handleErr()
    }

}
