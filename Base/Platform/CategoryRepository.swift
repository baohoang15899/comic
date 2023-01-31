//
//  CategoryRepository.swift
//  Base
//
//  Created by BaoHoang on 31/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol CategoryRepositoryType {
    func getAllCategory() -> Observable<Document>
}

struct CategoryRepository: CategoryRepositoryType {
    
    func getAllCategory() -> Observable<Document> {
        return Service.shared.request(input: CategoryRouter.all)
            .asObservable()
            .catchErrReturnElement(element: SwiftSoupService.shared.getEmptyDocument())
    }
}
