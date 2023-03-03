//
//  FavoriteRepository.swift
//  Base
//
//  Created by BaoHoang on 09/02/2023.
//

import Foundation
import RxSwift
import SwiftSoup
import CoreData

protocol FavoriteRepositoryType {
    func getAllFavorite() -> Observable<[ComicSuggestModel]>
    func deleteFavorite(id: String)
}

struct FavoriteRepository: FavoriteRepositoryType {
    
    func deleteFavorite(id: String) {
        let context = AppDelegate.shared.persistentContainer.viewContext
        do {
            let items = try context.fetch(DetailComicCoreData.fetchRequest())
            
            let hasItem = items.first { data in
                return data.id == id
            }
            
            if let item = hasItem {
                context.delete(item)
                try context.save()
            }
           
        } catch {
            print("Can't delete data")
        }
    }
    
    func getAllFavorite() -> Observable<[ComicSuggestModel]> {
//        // Create a new background managed object context
//        let context2 = AppDelegate.shared.persistentContainer.newBackgroundContext()
//
//        // If needed, ensure the background context stays
//        // up to date with changes from the parent
//        context2.automaticallyMergesChangesFromParent = true
//
//        // Perform operations on the background context
//        // asynchronously
//        context2.perform {
//            do {
//                // Create a fetch request
//                print("Core data in BG: \(Thread.current)")
//                let fetchRequest: NSFetchRequest<DetailComicCoreData>
//
//                fetchRequest = DetailComicCoreData.fetchRequest()
//                fetchRequest.fetchLimit = 1
//
//                let objects = try context2.fetch(fetchRequest)
//                objects.forEach { item in
//                    print(item)
//                }
//                // Handle fetched objects
//            }
//            catch let error {
//                // Handle error
//            }
//        }
        
        let context = AppDelegate.shared.persistentContainer.viewContext
        do {
            print("Core data in main: \(Thread.current)")
            let items = try context.fetch(DetailComicCoreData.fetchRequest())
            let favoriteComic = items.map { data -> ComicSuggestModel in
                let title = (data.chapter?.allObjects as? [ChapterCoreData])?
                    .sorted(by: { Int($0.chap ?? "0") ?? 0 > Int($1.chap ?? "0") ?? 0 })
                    .last?.title
                let comic = ComicSuggestModel(image: data.image ?? "",
                                              title: data.title ?? "",
                                              category: data.categories?.joined(separator: ", "),
                                              chapter: title,
                                              detailUrl: data.id ?? "")
                return comic
            }
            return Observable.just(favoriteComic.reversed())
        }
        catch {
            print("Can't fetch local data")
            return Observable.of([])
        }
    }
}
