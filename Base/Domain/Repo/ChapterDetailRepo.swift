//
//  ChapterDetailRepo.swift
//  Base
//
//  Created by baohoang on 23/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol ChapterDetailRepo {
    func getDetailChapter(urlStrPath: String) -> Observable<Document>
    func getChapterImg(chapter: ChapterDetailModel) -> Observable<ChapterImageModel>
}
