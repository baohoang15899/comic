//
//  WeatherRepo.swift
//  Base
//
//  Created by BaoHoang on 30/11/2022.
//

import Foundation
import RxSwift
import SwiftSoup

protocol TopComicRepo {
    func getHotComic(param: [String: Any]) -> Observable<Document>
    func getTopManga(param: [String: Any]) -> Observable<Document>
    func getTopManhwa(param: [String: Any]) -> Observable<Document>
    func getTopManhua(param: [String: Any]) -> Observable<Document>
    func getNominate() -> Observable<Document>
}
