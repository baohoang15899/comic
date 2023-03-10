//
//  FavoriteUC.swift
//  Base
//
//  Created by BaoHoang on 09/02/2023.
//

import Foundation
import RxSwift

protocol FavoriteUCType {
    func getAllFavorite() -> Observable<[ComicSuggestModel]>
    func deleteFavorite(id: String)
}

struct FavoriteUC: FavoriteUCType {

    private let favoriteRepository: FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    func getAllFavorite() -> Observable<[ComicSuggestModel]> {
        return favoriteRepository.getAllFavorite()
    }
    
    func deleteFavorite(id: String) {
        return favoriteRepository.deleteFavorite(id: id)
    }
    
}
