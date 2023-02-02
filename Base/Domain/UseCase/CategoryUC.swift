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
    func getAll(page: Int) -> Observable<[ComicModel]>
    func getAllCategory() -> Observable<[CategoryModel]>
}

struct CategoryUC: CategoryUCType {

    private let categoryRepository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.categoryRepository = repository
    }
    
    func getAll(page: Int) -> Observable<[ComicModel]> {
        return categoryRepository.getAllComic(page: page)
    }
    
    func getAllCategory() -> Observable<[CategoryModel]> {
        return categoryRepository.getAllCategory()
    }
    
}

