//
//  TopComicRepository.swift
//  Base
//
//  Created by BaoHoang on 03/02/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol TopComicRepositoryType {
    func getTopManga(param: [String: Any]) -> Observable<[ComicModel]>
    func getTopManhwa(param: [String: Any]) -> Observable<[ComicModel]>
    func getTopManhua(param: [String: Any]) -> Observable<[ComicModel]>
    func getNominate() -> Observable<[ComicModel]>
    func getHotComic(param: [String: Any]) -> Observable<[ComicModel]>
}

struct TopComicRepository: TopComicRepositoryType {
    
    func getHotComic(param: [String : Any]) -> Observable<[ComicModel]> {
        var comics: [ComicModel]?
        return Service.shared.request(input: TopComicRouter.hot(param: param))
            .asObservable()
            .map { data in
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "div.items-slide div.item")
                comics = results?.map({ value in
                    let imgUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                         className: "a img",
                                                                         attr: "data-src")
                    
                    let comicDetailUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                                 className: "a",
                                                                                 attr: "href")
                    
                    let title = SwiftSoupService.shared.elementToString(element: value,
                                                                        className: "h3 a")
                    return ComicModel(image: ComicModel.getUrlImg(img: imgUrl), title: title, detailUrl: comicDetailUrl ?? "", newChapter: "")
                })
                return comics ?? []
            }
    }

    func getNominate() -> Observable<[ComicModel]> {
        var comics: [ComicModel]?
        return Service.shared.request(input: TopComicRouter.nominate)
            .asObservable()
            .map { data in
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "div.items-slide div.item")
                comics = results?.map({ value in
                    let imgUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                         className: "a img",
                                                                         attr: "data-src")
                    
                    let comicDetailUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                                 className: "a",
                                                                                 attr: "href")
                    
                    let title = SwiftSoupService.shared.elementToString(element: value,
                                                                        className: "h3 a")
                    return ComicModel(image: ComicModel.getUrlImg(img: imgUrl), title: title, detailUrl: comicDetailUrl ?? "", newChapter: "")
                })
                return comics ?? []
            }
    }
    
    func getTopManga(param: [String: Any]) -> Observable<[ComicModel]> {
        var comics: [ComicModel]?
        return Service.shared.request(input: TopComicRouter.top(param: param))
            .asObservable()
            .map { data in
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "div.items div.item")
                comics = results?.map({ value in
                    let imgUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                         className: "div.image img",
                                                                         attr: "data-original")
                    
                    let comicDetailUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                                 className: "div.image a",
                                                                                 attr: "href")
                    
                    let title = SwiftSoupService.shared.elementToString(element: value,
                                                                        className: "h3 a")
                    return ComicModel(image: ComicModel.getUrlImg(img: imgUrl), title: title, detailUrl: comicDetailUrl ?? "", newChapter: "")
                })
                return comics ?? []
            }
    }
    
    func getTopManhwa(param: [String: Any]) -> Observable<[ComicModel]> {
        var comics: [ComicModel]?
        return Service.shared.request(input: TopComicRouter.topManhwa(param: param))
            .asObservable()
            .map { data in
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "div.items div.item")
                comics = results?.map({ value in
                    let imgUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                         className: "div.image img",
                                                                         attr: "data-original")
                    
                    let comicDetailUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                                 className: "div.image a",
                                                                                 attr: "href")
                    
                    let title = SwiftSoupService.shared.elementToString(element: value,
                                                                        className: "h3 a")
                    return ComicModel(image: ComicModel.getUrlImg(img: imgUrl), title: title, detailUrl: comicDetailUrl ?? "", newChapter: "")
                })
                return comics ?? []
            }
    }
    
    func getTopManhua(param: [String: Any]) -> Observable<[ComicModel]> {
        var comics: [ComicModel]?
        return Service.shared.request(input: TopComicRouter.topManhua(param: param))
            .asObservable()
            .map { data in
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "div.items div.item")
                comics = results?.map({ value in
                    let imgUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                         className: "div.image img",
                                                                         attr: "data-original")
                    
                    let comicDetailUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                                 className: "div.image a",
                                                                                 attr: "href")
                    
                    let title = SwiftSoupService.shared.elementToString(element: value,
                                                                        className: "h3 a")
                    return ComicModel(image: ComicModel.getUrlImg(img: imgUrl), title: title, detailUrl: comicDetailUrl ?? "", newChapter: "")
                })
                return comics ?? []
            }
    }
    
}
