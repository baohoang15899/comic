//
//  CategoryRepository.swift
//  Base
//
//  Created by BaoHoang on 31/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol CategoryRepositoryType {
    func getAllComic(page: Int, url: String) -> Observable<[ComicModel]>
    func getAllCategory() -> Observable<[CategoryModel]>
}

struct CategoryRepository: CategoryRepositoryType {
    
    func getAllCategory() -> Observable<[CategoryModel]> {
        var categories: [CategoryModel] = []

        return Service.shared.request(input: CategoryRouter.allCategory)
            .asObservable()
            .map { data in
                let result = SwiftSoupService.shared.getAllElements(document: data, className: "div.right-side.col-md-4.cmszone ul.nav li a")
                
               categories = result?.map({ value in
                   let title = SwiftSoupService.shared.elementToString(element: value, className: "a")
                   let url = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "a", attr: "href")
                   return CategoryModel(title: title, categoryUrl: url)
               }) ?? []
                
                return categories
            }
            .catchErrReturnElement(element: [])
    }
    
    func getAllComic(page: Int, url: String) -> Observable<[ComicModel]> {
        var comics: [ComicModel]?
        
        return Service.shared.request(input: CategoryRouter.allComic(page: page, url: url))
            .asObservable()
            .map { data in
                let nextPage = SwiftSoupService.shared.getSingleElement(document: data, className: "div.pagination-outter a.next-page")
                
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "div.Module.Module-170 div.items div.item")
            
               comics = results?.map({ value in
                   let image = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "div.image a img", attr: "data-original")
                   let title = SwiftSoupService.shared.elementToString(element: value, className: "figcaption h3 a")
                   let url = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "figcaption h3 a", attr: "href")
                   let newChapter = SwiftSoupService.shared.elementToString(element: value, className: "figcaption ul li a")
                   let updateTime = SwiftSoupService.shared.elementToString(element: value, className: "figcaption ul li i.time")
                   return ComicModel(image: ComicModel.getUrlImg(img: image),
                                     title: title,
                                     detailUrl: url,
                                     newChapter: "\(newChapter ?? "")  \(updateTime ?? "")")
                })
        
                return nextPage == nil ? [] : comics ?? []
            }
            .catchErrReturnElement(element: [])
    }
}
