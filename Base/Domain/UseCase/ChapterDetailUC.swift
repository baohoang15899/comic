//
//  ChapterDetailUC.swift
//  Base
//
//  Created by baohoang on 23/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol ChapterDetailUCType {
    func getChapterDetail(url: String) -> Observable<[ChapterDetailModel]>
    func getChapterImage(chapter: ChapterDetailModel) -> Observable<ChapterImageModel>
}

struct ChapterDetailUC: ChapterDetailUCType {
    
    private let repository: ChapterDetailRepository
    
    init(repository: ChapterDetailRepository) {
        self.repository = repository
    }
    
    func getChapterDetail(url: String) -> Observable<[ChapterDetailModel]> {
        return repository.getChapterDetail(url: url)
    }
    
    func getChapterImage(chapter: ChapterDetailModel) -> Observable<ChapterImageModel> {
        return repository.getChapterImage(chapter: chapter)
    }
}
