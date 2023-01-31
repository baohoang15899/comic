//
//  ComicSuggestModel.swift
//  Base
//
//  Created by BaoHoang on 27/01/2023.
//

import Foundation
import UIKit

struct ComicSuggestModel {
    let image: String?
    let title: String?
    let category: String?
    let chapter: String?
    let detailUrl: String?
    
    static func getUrlImg(img: String?) -> String {
        let url = img?.replacingOccurrences(of: "//", with: "https://") ?? ""
        return url
    }
}
