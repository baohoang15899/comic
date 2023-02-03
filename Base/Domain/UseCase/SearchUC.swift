//
//  SearchUC.swift
//  Base
//
//  Created by BaoHoang on 27/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol SearchUCType {
    func searchComic(keyword: String) -> Observable<[ComicSuggestModel]>
}

struct SearchUC: SearchUCType {
    
    private let searchRepository: SearchRepository
    
    init(repository: SearchRepository) {
        self.searchRepository = repository
    }
    
    func searchComic(keyword: String) -> Observable<[ComicSuggestModel]> {
        return searchRepository.searchComic(keyword: keyword)
    }
    
}
