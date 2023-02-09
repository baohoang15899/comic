//
//  DetailComicModel.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import Foundation

class DetailComicModel {
    let image: String?
    let title: String?
    let chapters: [ChapterModel]?
    let author: String?
    let status: String?
    let categories: [String]?
    let content: String?
    let isFavorite: Bool?
    let id: String?
    
    init(image: String?, title: String?, chapters: [ChapterModel]?, author: String?, status: String?, categories: [String]?, content: String?, isFavorite: Bool?, id: String?) {
        self.image = image
        self.title = title
        self.chapters = chapters
        self.author = author
        self.status = status
        self.categories = categories
        self.content = content
        self.isFavorite = isFavorite
        self.id = id
    }
    
    convenience init() {
        self.init(image: "", title: "", chapters: [], author: "", status: "", categories: [""], content: "", isFavorite: false, id: "")
    }

    static func getUrlImg(img: String?) -> String {
        let url = img?.replacingOccurrences(of: "//", with: "https://") ?? ""
        return url
    }
}
