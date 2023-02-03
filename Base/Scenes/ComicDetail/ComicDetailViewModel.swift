//  ComicDetailViewModel.swift
//  Base
//
//  Created by baohoang on 20/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import Foundation
import RxSwift
import RxCocoa

class ComicDetailViewModel: BaseViewModel {
    
    struct Input {
        let getComicDetail: Driver<Void>
    }
    
    struct Output {
        let comicDetailSection: Driver<[ComicDetailSectionData]>
    }
    
    private let bag = DisposeBag()
    private let detailComicUrl: String
    private let comicDetailSectionSubject = BehaviorSubject<[ComicDetailSectionData]>(value: [])
    private let comicDetailUC: ComicDetailUC
    
    init(detailComicUrl: String, comicDetailUC: ComicDetailUC) {
        self.detailComicUrl = detailComicUrl
        self.comicDetailUC = comicDetailUC
    }
    
    deinit {
        print("\(self) deinit")
    }

    func transform(input: Input) -> Output {
        
        let comicDetailSectionOutput = input.getComicDetail
            .flatMap { _ in
                return self.comicDetailUC.getComicDetail(url: self.detailComicUrl)
                    .asDriver(onErrorJustReturn: [])
            }
        
        return Output(comicDetailSection: comicDetailSectionOutput)
    }
}
