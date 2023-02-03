//
//  ComicDetailUC.swift
//  Base
//
//  Created by BaoHoang on 03/02/2023.
//

import Foundation
import RxSwift

protocol ComicDetailUCType {
    func getComicDetail(url: String) -> Observable<[ComicDetailSectionData]>
}

struct ComicDetailUC: ComicDetailUCType {

    private let comicDetailRepository: ComicDetailRepository
    
    init(repository: ComicDetailRepository) {
        self.comicDetailRepository = repository
    }
    
    func getComicDetail(url: String) -> Observable<[ComicDetailSectionData]> {
        return comicDetailRepository.getComicDetail(url: url)
    }
}
