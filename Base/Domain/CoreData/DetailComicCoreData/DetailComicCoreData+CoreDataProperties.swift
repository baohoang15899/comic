//
//  DetailComicCoreData+CoreDataProperties.swift
//  Base
//
//  Created by BaoHoang on 09/02/2023.
//
//

import Foundation
import CoreData


extension DetailComicCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetailComicCoreData> {
        return NSFetchRequest<DetailComicCoreData>(entityName: "DetailComicCoreData")
    }

    @NSManaged public var author: String?
    @NSManaged public var categories: [String]?
    @NSManaged public var chapters: [ChapterModel]?
    @NSManaged public var content: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var status: String?
    @NSManaged public var title: String?

}
