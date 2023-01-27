//
//  SearchRepo.swift
//  Base
//
//  Created by BaoHoang on 27/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol SearchRepo {
    func getSearchComic(keyword: String) -> Observable<Document>
}
