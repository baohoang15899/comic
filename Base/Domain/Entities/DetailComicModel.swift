//
//  DetailComicModel.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import Foundation

struct DetailComicModel {
    let image: String?
    let title: String?
    let chapters: [ChapterModel]?
    let author: String?
    let status: String?
    let categories: [String]?
    let content: String?
    
    static func getUrlImg(img: String?) -> String {
        let url = img?.replacingOccurrences(of: "//", with: "https://") ?? ""
        return url
    }
}
