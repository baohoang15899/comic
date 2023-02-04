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
    func getChapterImage(chapter: ChapterDetailModel) -> Observable<ChapterImageModel>
}

struct ChapterDetailRepository: ChapterDetailRepositoryType {
    
    func getChapterImage(chapter: ChapterDetailModel) -> Observable<ChapterImageModel> {
        return Service.shared.requestImage(input: ChapterDetailRouter.getChapterImg(url: chapter.url ?? ""), dataIndex: chapter.dataIndex ?? "")
            .asObservable()
            .catchErrReturnEmpty()
    }
    
    func getChapterDetail(url: String) -> Observable<[ChapterDetailModel]> {
        return Service.shared.request(input: ChapterDetailRouter.getChapter(url: url))
            .asObservable()
            .map { data in
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "main div.reading-detail.box_doc div.page-chapter")
                
                
                let chapters: [ChapterDetailModel] = results?.map({ value -> ChapterDetailModel in
                    
                    let img = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "img", attr: "data-original")
                    let dataIndex = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "img", attr: "data-index")
                    return ChapterDetailModel(url: ChapterDetailModel.getUrlImg(img: img), dataIndex: dataIndex)
                }) ?? []
                
                return chapters
            }
    }
}
