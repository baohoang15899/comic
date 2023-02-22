//
//  SearchRepository.swift
//  Base
//
//  Created by BaoHoang on 03/02/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol SearchRepositoryType {
    func searchComic(keyword: String) -> Observable<[ComicSuggestModel]>
}

struct SearchRepository: SearchRepositoryType {
    func searchComic(keyword: String) -> Observable<[ComicSuggestModel]> {
        var comicSuggestData: [ComicSuggestModel] = []
        
        return Service.shared.request(input: SearchRouter.search(keyword: keyword))
            .asObservable()
            .map({ data in
                let results = SwiftSoupService.getAllElements(document: data, className: "body ul li")
                results?.forEach({ value in
                    let image = SwiftSoupService.getAttrFromHtml(element: value, className: "a img", attr: "src")
                    let title = SwiftSoupService.elementToString(element: value, className: "a h3")
                    let detailUrl = SwiftSoupService.getAttrFromHtml(element: value, className: "a", attr: "href")
                    let chapter = SwiftSoupService.elementToString(element: value, className: "h4 i")
                    let category = SwiftSoupService.lastSiblingToString(element: value, className: "h4 i")
                    comicSuggestData.append(ComicSuggestModel(image: ComicSuggestModel.getUrlImg(img: image),
                                                              title: title ?? L10n.Common.Update.empty,
                                                              category: category ?? L10n.Common.Update.empty,
                                                              chapter: chapter ?? L10n.Common.Update.empty,
                                                              detailUrl: detailUrl))
                })
                return comicSuggestData
            })
            .catchErrReturnElement(element: [])
    }
}
