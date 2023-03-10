//  HomeModel.swift
//  Base
//
//  Created by BaoHoang on 15/10/2022.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import UIKit
import RxDataSources

enum HomeSectionType {
    case normal
    case banner
}

struct HomeHeaderWeatherModel {
    let cityName: String?
    let status: String?
    let celsius: String?
}

struct HomeSectionModel {
    let data: [ComicModel]?
}

struct HomeSectionData {
  var header: String?
  var items: [Item]
  var type: HomeSectionType
}

extension HomeSectionData: SectionModelType {
  typealias Item = HomeSectionModel

   init(original: HomeSectionData, items: [Item]) {
    self = original
    self.items = items
  }
}
