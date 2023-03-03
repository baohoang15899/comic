//
//  ComicDetailUC.swift
//  Base
//
//  Created by BaoHoang on 03/02/2023.
//

import Foundation
import RxSwift

protocol ComicDetailUCType {
    func getComicDetailSection(data: DetailComicModel) -> Observable<[ComicDetailSectionData]>
    func setFavorite(detailComic: DetailComicModel) -> Observable<Bool>
    func getComicDetailData(url: String) -> Observable<DetailComicModel>
    func getFavorite(detailComic: DetailComicModel) -> Observable<Bool>
    func saveChapterToLocal(detailComic: DetailComicModel)
}

struct ComicDetailUC: ComicDetailUCType {

    private let comicDetailRepository: ComicDetailRepository
    
    init(repository: ComicDetailRepository) {
        self.comicDetailRepository = repository
    }
    
    func setFavorite(detailComic: DetailComicModel) -> Observable<Bool> {
        return comicDetailRepository.setFavorite(detailComic: detailComic)
    }
    
    func getComicDetailSection(data: DetailComicModel) -> Observable<[ComicDetailSectionData]> {
        return comicDetailRepository.getComicDetailSection(data: data)
    }
    
    func getFavorite(detailComic: DetailComicModel) -> Observable<Bool> {
        return comicDetailRepository.getFavorite(detailComic: detailComic)
    }
    
    func getComicDetailData(url: String) -> Observable<DetailComicModel> {
        return comicDetailRepository.getComicDetailData(url: url)
    }
    
    func saveChapterToLocal(detailComic: DetailComicModel) {
        comicDetailRepository.saveComicToLocal(detailComic: detailComic)
    }
}
