//  HomeViewModel.swift
//  Base
//
//  Created by BaoHoang on 15/10/2022.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import Foundation
import RxSwift
import RxCocoa
import SwiftSoup

class HomeViewModel: BaseViewModel {
    
    struct Input {
        let fetchData: Driver<Void>
        let pullToRefresh: Driver<Void>
    }
    
    struct Output {
        let homeSection: Driver<[HomeSectionData]>
        let isRefresing: Driver<Bool>
        let isEmpty: Driver<Bool>
        let isLoading: Driver<Bool>
    }
    
    private let bag = DisposeBag()
    private let topComicUC: TopComicUC
    private let coordinator: HomeCoordinator
    
    let didSelectItem = PublishSubject<(String, String)>()
    
    init(topComicUC: TopComicUC, coordinator: HomeCoordinator) {
        self.topComicUC = topComicUC
        self.coordinator = coordinator
    }

    private func fetchHomeData() -> Observable<[HomeSectionData]> {
        
        let nomiateOutput = topComicUC.getNominate()
        
        let hotComicOutput = topComicUC.getHotComic(param: ["page": 1])
        
        let topMangaOutput = topComicUC.getTopManga(param: ["status": -1, "sort": 11])
        
        let topManhwaOutput = topComicUC.getTopManhwa(param: ["status": -1, "sort": 11])
        
        let topManhuaOutput = topComicUC.getTopManhua(param: ["status": -1, "sort": 11])
        
        let allComic = Observable.zip(nomiateOutput,hotComicOutput, topMangaOutput, topManhwaOutput, topManhuaOutput)

        let homeSectionOutput = allComic.map {(nominate, hotComic, topManga, topManhwa, topManhua) -> [HomeSectionData] in
            let nominateSection = HomeSectionData(header: L10n.Home.Section.nominate, items: [HomeSectionModel(data: nominate)], type: .banner)
            let hotSection = HomeSectionData(header: L10n.Home.Section.hot, items: [HomeSectionModel(data: hotComic)], type: .normal)
            let topMangaSection = HomeSectionData(header: L10n.Home.Section.topManga, items: [HomeSectionModel(data: topManga)], type: .normal)
            let topManhwaSection = HomeSectionData(header: L10n.Home.Section.topManhwa, items: [HomeSectionModel(data: topManhwa)], type: .normal)
            let topManhuaSection = HomeSectionData(header: L10n.Home.Section.topManhua, items: [HomeSectionModel(data: topManhua)], type: .normal)
            return [nominateSection, hotSection, topMangaSection, topManhwaSection, topManhuaSection]
        }
        
        return homeSectionOutput
    }
    
    func transform(input: Input) -> Output {

        let isRefreshingRelay = BehaviorRelay<Bool>(value: false)
        let isLoadingSubject = BehaviorSubject<Bool>(value: false)
        let homeSubjectIsEmpty = PublishSubject<Bool>()
        
        self.didSelectItem
            .subscribe { url, title  in
                self.coordinator.navigateToComicDetail(comicDetailUrl: url, title: title)
            }
            .disposed(by: bag)
        
        let homeMerge = Driver.merge(input.fetchData, input.pullToRefresh)
        
        input.pullToRefresh
            .asObservable()
            .subscribe(onNext: {
                isRefreshingRelay.accept(true)
            })
            .disposed(by: bag)

        let homeSectionOutput = homeMerge
            .do(onNext: { _ in
                if (!isRefreshingRelay.value) {
                    isLoadingSubject.onNext(true)
                }
            })
            .flatMap { _ in
                return self.fetchHomeData()
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: { data in
                isRefreshingRelay.accept(false)
                homeSubjectIsEmpty.onNext(!data.isEmpty)
                isLoadingSubject.onNext(false)
            })

        let isRefresingOutput = isRefreshingRelay.asDriver(onErrorJustReturn: false)
        let isEmptyOutput = homeSubjectIsEmpty.asDriver(onErrorJustReturn: false)
        let isLoadingOutput = isLoadingSubject.asDriver(onErrorJustReturn: false)
                
        return Output(homeSection: homeSectionOutput,
                      isRefresing: isRefresingOutput,
                      isEmpty: isEmptyOutput,
                      isLoading: isLoadingOutput)
    }
}
