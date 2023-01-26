//
//  DetailComicRepo.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol DetailComicRepo {
    func getDetailComic(urlStrPath: String) -> Observable<Document>
}
