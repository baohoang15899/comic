//
//  ComicDetailRepository.swift
//  Base
//
//  Created by BaoHoang on 03/02/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol ComicDetailRepositoryType {
    func getComicDetailSection(data: DetailComicModel) -> Observable<[ComicDetailSectionData]>
    func setFavorite(detailComic: DetailComicModel) -> Observable<Bool>
    func getComicDetailData(url: String) -> Observable<DetailComicModel>
    func getFavorite(detailComic: DetailComicModel) -> Observable<Bool>
}

struct ComicDetailRepository: ComicDetailRepositoryType {

    func getComicDetailData(url: String) -> Observable<DetailComicModel> {
        return Service.shared.request(input: ComicDetailRouter.detail(urlStrPath: url))
            .asObservable()
            .map({ data -> DetailComicModel in
                
                let results = SwiftSoupService.shared.getSingleElement(document: data,
                                                                       className: "main article")
                
                let imageInfo = SwiftSoupService.shared.getSingleElement(document: data,
                                                                         className: "main article div.detail-info")
                
                let comicInfo = SwiftSoupService.shared.getSingleElement(document: data,
                                                                         className: "main article div.detail-info div.col-xs-8.col-info")
                
                let kindInfo = SwiftSoupService.shared.getAllElements(document: data,
                                                                      className: "div.col-xs-8.col-info li.kind.row p.col-xs-8 a")
                
                let contentInfo = SwiftSoupService.shared.getSingleElement(document: data,
                                                                           className: "main div.detail-content p")
                
                let listChapterInfo = SwiftSoupService.shared.getAllElements(document: data,
                                                                             className: "main div.list-chapter nav ul li.row")
                
                // data
                let title = SwiftSoupService.shared.elementToString(element: results,
                                                                    className: "h1.title-detail")
                
                let img = SwiftSoupService.shared.getAttrFromHtml(element: imageInfo,
                                                                  className: "div.row div.col-xs-4.col-image img",
                                                                  attr: "src")
                
                let author = SwiftSoupService.shared.elementToString(element: comicInfo,
                                                                     className: "ul.list-info li.author.row p.col-xs-8")
                
                let status = SwiftSoupService.shared.elementToString(element: comicInfo,
                                                                     className: "ul.list-info li.status.row p.col-xs-8")
                
                let kinds: [String] = kindInfo?.map({ value -> String in
                    return SwiftSoupService.shared.elementToString(element: value,
                                                                   className: "a") ?? ""
                }) ?? []
                
                let chapters: [ChapterModel] = listChapterInfo?.map({ value -> ChapterModel in
                    let title = SwiftSoupService.shared.elementToString(element: value,
                                                                        className: "div.col-xs-5.chapter a")
                    
                    let chapterUrl = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                             className: "div.col-xs-5.chapter a",
                                                                             attr: "href")
                    
                    let date = SwiftSoupService.shared.elementToString(element: value, className: "div.col-xs-4.text-center.no-wrap.small")
                    
                    let id = SwiftSoupService.shared.getAttrFromHtml(element: value,
                                                                     className: "div.col-xs-5.chapter a",
                                                                     attr: "data-id")
                    
                    return ChapterModel(id: id, title: title, chapterUrl: chapterUrl, chap: "", date: date)
                }) ?? []
                
                let content = SwiftSoupService.shared.elementToString(element: contentInfo,
                                                                      className: "p")
                
                return DetailComicModel(image: DetailComicModel.getUrlImg(img: img),
                                        title: title,
                                        chapters: chapters,
                                        author: author,
                                        status: status,
                                        categories: kinds,
                                        content: content,
                                        isFavorite: false,
                                        id: url
                )
            })
    }
    
    func getFavorite(detailComic: DetailComicModel) -> Observable<Bool> {
        let context = AppDelegate.shared.persistentContainer.viewContext
        
        do {
            let items = try context.fetch(DetailComicCoreData.fetchRequest())
            let hasItem = items.first { data in
                return data.id == detailComic.id && data.isFavorite
            }
            return hasItem != nil ? Observable.just(true) : Observable.just(false)
        }
        catch {
            print("Can't fetch local data")
            return Observable.just(false)
        }
    }
    
    func setFavorite(detailComic: DetailComicModel) -> Observable<Bool> {
        let context = AppDelegate.shared.persistentContainer.viewContext
        var i = 0
        do {
            let items = try context.fetch(DetailComicCoreData.fetchRequest())
//            for object in items {
//                context.delete(object)
//            }
            let hasItem = items.first { data in
                return data.id == detailComic.id
            }

            if (hasItem != nil && ((hasItem?.isFavorite) != nil)) {
                if let data = hasItem {
                    context.delete(data)
                    try context.save()
                }
                NotificationCenter.default.post(name: NSNotification.Name(NotificationCenterKey.favorite),
                                                        object: nil)
                return Observable.just(false)
            } else {
                let saveItem = DetailComicCoreData(context: context)
                detailComic.chapters?.forEach({ data in
                    i += 1
                    let chapter = ChapterCoreData(context: context)
                    chapter.id = data.id
                    chapter.title = data.title
                    chapter.chapterUrl = data.chapterUrl
                    chapter.date = data.date
                    chapter.chap = "\(i)"
                    saveItem.addToChapter(chapter)
                })
                saveItem.id = detailComic.id
                saveItem.title = detailComic.title
                saveItem.image = detailComic.image
                saveItem.author = detailComic.author
                saveItem.categories = detailComic.categories
                saveItem.content = detailComic.content
                saveItem.status = detailComic.status
                saveItem.isFavorite = true
                try context.save()
                NotificationCenter.default.post(name: NSNotification.Name(NotificationCenterKey.favorite),
                                                        object: nil)
                return Observable.just(true)
            }
        }
        catch {
            print("Can't fetch local data")
            return Observable.just(false)
        }
    }
    
    func getComicDetailSection(data: DetailComicModel) -> Observable<[ComicDetailSectionData]> {
        
        let mainInfoSection = ComicDetailMainInfoModel(title: data.title,
                                                       img: data.image,
                                                       author: data.author,
                                                       status: data.status)
        
        let contentSection = ComicDetailContentModel(content: data.content)
        
        let chapterSection: [ComicDetailChapterModel] = data.chapters?.map({ chapter in
            return ComicDetailChapterModel(chapter: chapter)
        }) ?? []
        
        let categorySection = ComicDetailCategoryModel(categories: data.categories)
        
        let mainInfoSectionData = ComicDetailSectionData(header: "",
                                                         items: [mainInfoSection],
                                                         type: .info)
        let categorySectionData = ComicDetailSectionData(header: L10n.ComicDetail.Section.category,
                                                         items: [categorySection],
                                                         type: .category)
        
        let contentSectionData = ComicDetailSectionData(header: L10n.ComicDetail.Section.content,
                                                        items: [contentSection],
                                                        type: .content)
        
        let chapterSectionData = ComicDetailSectionData(header: L10n.ComicDetail.Section.chapter,
                                                        items: chapterSection,
                                                        type: .chapter)
        
        return Observable.of([mainInfoSectionData,categorySectionData, contentSectionData, chapterSectionData])
    }
}
