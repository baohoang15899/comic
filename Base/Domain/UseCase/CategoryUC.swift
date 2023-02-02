//
//  CategoryUC.swift
//  Base
//
//  Created by BaoHoang on 31/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol CategoryUCType {
    func getAllComic(page: Int, url: String) -> Observable<[ComicModel]>
    func getAllCategory() -> Observable<[CategoryModel]>
}

struct CategoryUC: CategoryUCType {

    private let categoryRepository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.categoryRepository = repository
    }
    
    func getAllComic(page: Int, url: String) -> Observable<[ComicModel]> {
        return categoryRepository.getAllComic(page: page, url: url)
    }
    
    func getAllCategory() -> Observable<[CategoryModel]> {
        return categoryRepository.getAllCategory()
    }
    
}

