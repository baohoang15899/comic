//
//  FavoriteRepository.swift
//  Base
//
//  Created by BaoHoang on 09/02/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol FavoriteRepositoryType {
    func getAllFavorite() -> Observable<[ComicSuggestModel]>
}

struct FavoriteRepository: FavoriteRepositoryType {
    func getAllFavorite() -> Observable<[ComicSuggestModel]> {
        let context = AppDelegate.shared.persistentContainer.viewContext
        do {
            let items = try context.fetch(DetailComicCoreData.fetchRequest())
            let chapters = try context.fetch(ChapterCoreData.fetchRequest())
            let favoriteComic = items.map { data in
                let comic = ComicSuggestModel(image: data.image ?? "",
                                  title: data.title ?? "",
                                  category: data.categories?.joined(separator: ", "),
                                             chapter: chapters.last?.title,
                                  detailUrl: data.id ?? "")
                return comic
            }
            return Observable.just(favoriteComic.reversed())
        }
        catch {
            print("Cant fetch local data")
            return Observable.of([])
        }
    }
}
