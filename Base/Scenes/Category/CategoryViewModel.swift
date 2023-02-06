//  CategoryViewModel.swift
//  Base
//
//  Created by BaoHoang on 31/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import Foundation
import RxSwift
import RxCocoa
import SwiftSoup
import UIKit

class CategoryViewModel: BaseViewModel {
    
    struct Input {
        let willDisplayCell: Driver<(cell: UITableViewCell, indexPath: IndexPath )>
        let didSelectedItem: Driver<(row: Int, component: Int)>
        let didSelectedComic: Driver<ComicModel>
        let getAllCategory: Driver<Void>
        let onTapPickerView: Driver<Void>
    }
    
    struct Output {
        let allComic: Driver<[ComicModel]>
        let allCategory: Driver<[CategoryModel]>
        let categoryTitle: Driver<String>
        let pickerViewSubmit: Driver<Void>
    }
    
    private let bag = DisposeBag()
    private let categoryUC: CategoryUC
    private let coordinator: CategoryCoordinator
    
    init(categoryUC: CategoryUC, coordinator: CategoryCoordinator) {
        self.categoryUC = categoryUC
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        let comicsRelay = BehaviorRelay<[ComicModel]>(value: [])
        let submitSubject = PublishSubject<Void>()
        let nextPageSubject = PublishSubject<Void>()
        let categoryTitleRelay = BehaviorRelay<String>(value: "")
        let categoryRelay = BehaviorRelay<CategoryModel>(value: CategoryModel(title: "", categoryUrl: ""))
        let pageRelay = BehaviorRelay<Int>(value: 1)
        var canLoadMore: Bool = true

        
        let startGetAllComic = Driver.merge(
            categoryRelay.skip(1).asDriver(onErrorJustReturn: CategoryModel(title: "", categoryUrl: "")).mapToVoid(), nextPageSubject.asDriver(onErrorJustReturn: ())
        )
        
        let allCategoryOutput = input.getAllCategory
            .asObservable()
            .flatMap { _ in
                return self.categoryUC.getAllCategory()
            }
            .do(onNext: { data in
                if let category = data.first {
                    categoryTitleRelay.accept(category.title ?? "")
                    categoryRelay.accept(category)
                }
            })
            .asDriver(onErrorJustReturn: [])
                
        let selectedItem = input.didSelectedItem
        .asObservable()
        .withLatestFrom(allCategoryOutput) { pickerData, categories in
            return categories[pickerData.row]
        }
        
        input.didSelectedComic
            .asObservable()
            .subscribe(onNext: { data in
                self.coordinator.navigateToComicDetail(comicDetailUrl: data.detailUrl ?? "",
                                                       title: data.title ?? "")
            })
            .disposed(by: bag)
        
        input.willDisplayCell
            .asObservable()
            .withLatestFrom(comicsRelay) { cell, comics -> Bool in
                let lastRow = comics.count - 1
                if(cell.indexPath.row == lastRow) {
                    return true
                } else {
                    return false
                }
            }
            .subscribe(onNext: { isLoadMore in
                if(isLoadMore && canLoadMore) {
                    let page = pageRelay.value + 1
                    pageRelay.accept(page)
                    nextPageSubject.onNext(())
                }
            })
            .disposed(by: bag)
        
        input.onTapPickerView
            .asObservable()
            .do(onNext: {
                submitSubject.onNext(())
            })
            .withLatestFrom(selectedItem) { _, data in
                return data
            }
            .subscribe(onNext: { data in
                comicsRelay.accept([])
                pageRelay.accept(1)
                categoryRelay.accept(data)
                categoryTitleRelay.accept(data.title ?? "")
            })
            .disposed(by: bag)
        
        startGetAllComic
            .asObservable()
            .flatMap { _ in
                return self.categoryUC.getAllComic(page: pageRelay.value, url: categoryRelay.value.categoryUrl ?? "")
            }
            .subscribe(onNext: { data in
                comicsRelay.accept(comicsRelay.value + data)
                canLoadMore = !data.isEmpty
            })
            .disposed(by: bag)
        
        let allComicOutput = comicsRelay.asDriver(onErrorJustReturn: [])
        let categoryTitleOutput = categoryTitleRelay.skip(1).asDriver(onErrorJustReturn: "")
        let pickerViewOntapOutput = submitSubject.asDriver(onErrorJustReturn: ())
        
        return Output(allComic: allComicOutput,
                      allCategory: allCategoryOutput,
                      categoryTitle: categoryTitleOutput,
                      pickerViewSubmit: pickerViewOntapOutput
        )
    }
}
