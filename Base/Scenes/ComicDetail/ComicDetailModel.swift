//
//  ComicDetailModel.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import Foundation
import RxDataSources

protocol ComicDetailSection {}

enum ComicDetailSectionType {
    case info
    case content
    case chapter
    case category
}

struct ComicDetailMainInfoModel: ComicDetailSection {
    let title: String?
    let img: String?
    let author: String?
    let status: String?
}

struct ComicDetailContentModel: ComicDetailSection {
    let content: String?
}

struct ComicDetailChapterModel: ComicDetailSection {
    let chapter: ChapterModel?
}

struct ComicDetailCategoryModel: ComicDetailSection {
    let categories: [String]?
}

struct ComicDetailSectionData {
  var header: String?
  var items: [Item]
  var type: ComicDetailSectionType
}

extension ComicDetailSectionData: SectionModelType {
  typealias Item = ComicDetailSection

   init(original: ComicDetailSectionData, items: [Item]) {
    self = original
    self.items = items
  }
}


