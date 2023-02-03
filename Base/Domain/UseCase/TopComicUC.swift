//
//  TopComicUC.swift
//  Base
//
//  Created by baohoang on 22/01/2023.
//

import Foundation
import RxSwift
import SwiftSoup

protocol TopComicUCType {
    func getTopManga(param: [String: Any]) -> Observable<[ComicModel]>
    func getTopManhwa(param: [String: Any]) -> Observable<[ComicModel]>
    func getTopManhua(param: [String: Any]) -> Observable<[ComicModel]>
    func getNominate() -> Observable<[ComicModel]>
    func getHotComic(param: [String: Any]) -> Observable<[ComicModel]>
}

struct TopComicUC: TopComicUCType {
    
    private let topComicRepository: TopComicRepository
    
    init(repository: TopComicRepository) {
        self.topComicRepository = repository
    }
    
    func getTopManga(param: [String : Any]) -> Observable<[ComicModel]> {
        return topComicRepository.getTopManga(param: param)
    }
    
    func getTopManhwa(param: [String : Any]) -> Observable<[ComicModel]> {
        return topComicRepository.getTopManhwa(param: param)
    }
    
    func getTopManhua(param: [String : Any]) -> Observable<[ComicModel]> {
        return topComicRepository.getTopManhua(param: param)
    }
    
    func getNominate() -> Observable<[ComicModel]> {
        return topComicRepository.getNominate()
    }
    
    func getHotComic(param: [String : Any]) -> Observable<[ComicModel]> {
        return topComicRepository.getHotComic(param: param)
    }
}
