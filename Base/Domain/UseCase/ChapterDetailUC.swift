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
    
    func getChapterImg(chapter: ChapterDetailModel) -> Observable<ChapterImageModel> {
        return Service.shared.requestImage(input: ChapterDetailRouter.getChapterImg(url: chapter.url ?? ""), dataIndex: chapter.dataIndex ?? "")
            .asObservable()
            .handleErr()
    }
    
    func getDetailChapter(urlStrPath: String) -> Observable<Document> {
        return Service.shared.request(input: ChapterDetailRouter.getChapter(url: urlStrPath))
            .asObservable()
            .handleErr()
    }

}
