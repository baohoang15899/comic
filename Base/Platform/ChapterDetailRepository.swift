//
//  ChapterDetailRepository.swift
//  Base
//
//  Created by BaoHoang on 03/02/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol ChapterDetailRepositoryType {
    func getChapterDetail(url: String) -> Observable<[ChapterDetailModel]>
}

struct ChapterDetailRepository: ChapterDetailRepositoryType {
    func getChapterDetail(url: String) -> Observable<[ChapterDetailModel]> {
        return Service.shared.request(input: ChapterDetailRouter.getChapter(url: url))
    }
}
