//
//  ChapterDetailModel.swift
//  Base
//
//  Created by baohoang on 23/01/2023.
//

import Foundation

struct ChapterDetailModel {
    let url: String?
    let dataIndex: String?
    
    static func getUrlImg(img: String?) -> String {
        let url = img?.replacingOccurrences(of: "//", with: "https://") ?? ""
        return url
    }
}
