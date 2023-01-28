//  SearchViewModel.swift
//  Base
//
//  Created by BaoHoang on 27/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    
    struct Input {
        let searchString: Driver<String>
        let didSelectItem: Driver<ComicSuggestModel>
    }
    
    struct Output {
        let comicSuggest: Driver<[ComicSuggestModel]>
        let selectedItem: Driver<ComicSuggestModel>
        let comicSuggestIsEmpty: Driver<Bool>
    }
    
    deinit {
        print("vm search deinit")
    }
    
    private let bag = DisposeBag()
    private let comicSuggestSubjectIsEmpty = BehaviorSubject<Bool>(value: true)

    func transform(input: Input) -> Output {
        
        let selectedItemOutput = input.didSelectItem
            .map({ data -> ComicSuggestModel in
                return data
            })
        
       let comicSuggestOutput = input.searchString
            .asObservable()
            .debounce(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged()
            .flatMap({ key in
                return RepoFactory.SearchRepo().getSearchComic(keyword: key)
            })
            .map({ data -> [ComicSuggestModel] in
                var comicSuggestData: [ComicSuggestModel] = []
                let results = SwiftSoupService.shared.getAllElements(document: data, className: "body ul li")
                results?.forEach({ value in
                    let image = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "a img", attr: "src")
                    let title = SwiftSoupService.shared.elementToString(element: value, className: "a h3")
                    let detailUrl = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "a", attr: "href")
                    let chapter = SwiftSoupService.shared.elementToString(element: value, className: "h4 i")
                    let category = SwiftSoupService.shared.lastSiblingToString(element: value, className: "h4 i")
                    comicSuggestData.append(ComicSuggestModel(image: ComicSuggestModel.getUrlImg(img: image),
                                                              title: title ?? L10n.Common.Update.empty,
                                                              category: category ?? L10n.Common.Update.empty,
                                                              chapter: chapter ?? L10n.Common.Update.empty,
                                                              detailUrl: detailUrl))
                })
                self.comicSuggestSubjectIsEmpty.onNext(!comicSuggestData.isEmpty)
                return comicSuggestData
            }).asDriver(onErrorJustReturn: [])
        
        let comicSuggestIsEmptyOutput = comicSuggestSubjectIsEmpty.skip(1).asDriver(onErrorJustReturn: true)
        
        return Output(comicSuggest: comicSuggestOutput,
                      selectedItem: selectedItemOutput,
                      comicSuggestIsEmpty: comicSuggestIsEmptyOutput)
    }
}
