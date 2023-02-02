//  ComicEntityModel.swift
//  Base
//
//  Created by BaoHoang on 17/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import UIKit

struct ComicModel {
    let image: String?
    let title: String?
    let detailUrl: String?
    let newChapter: String?
    
    static func getUrlImg(img: String?) -> String {
        let url = img?.replacingOccurrences(of: "//", with: "https://") ?? ""
        return url
    }
}
