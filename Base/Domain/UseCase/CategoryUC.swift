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
    func getAll(param: [String: Any]) -> Observable<Document>
}

struct CategoryUC: CategoryUCType {

    private let categoryRepository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.categoryRepository = repository
    }
    
    func getAll(param: [String : Any]) -> Observable<Document> {
        return categoryRepository.getAllCategory()
    }
    
}

