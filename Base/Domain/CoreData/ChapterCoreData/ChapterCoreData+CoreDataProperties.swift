//
//  ChapterCoreData+CoreDataProperties.swift
//  Base
//
//  Created by BaoHoang on 09/02/2023.
//
//

import Foundation
import CoreData


extension ChapterCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChapterCoreData> {
        return NSFetchRequest<ChapterCoreData>(entityName: "ChapterCoreData")
    }

    @NSManaged public var chap: String?
    @NSManaged public var chapterUrl: String?
    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var comic: DetailComicCoreData?

}
