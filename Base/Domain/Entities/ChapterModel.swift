//
//  ChapterModel.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import Foundation

public class ChapterModel: NSObject {
    let id: String?
    let title: String?
    let chapterUrl: String?
    let chap: String?
    let date: String?
    var isRead: Bool?
    
    init(id: String? = nil, title: String? = nil, chapterUrl: String? = nil, chap: String? = nil, date: String? = nil, isRead: Bool? = nil) {
        self.id = id
        self.title = title
        self.chapterUrl = chapterUrl
        self.chap = chap
        self.date = date
        self.isRead = isRead
    }
}
