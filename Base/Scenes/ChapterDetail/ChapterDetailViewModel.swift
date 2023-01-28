//  ChapterDetailViewModel.swift
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

class ChapterDetailViewModel: BaseViewModel {
    
    struct Input {
        let getChapterDetail: Driver<Void>
    }
    
    struct Output {
        let chapterImageOutput: Driver<[ChapterImageModel]>
    }
    
    private let bag = DisposeBag()
    private let chapter: ChapterModel
    private let getChapterImgSubject = BehaviorSubject<[ChapterDetailModel]>.init(value: [])
    private let dowloadImgSubject = PublishSubject<[Data]>()
    private var chapterDetail: [ChapterImageModel] = []
    private let chapterImageSubject = BehaviorSubject<[ChapterImageModel]>(value: [])
    
    init(chapter: ChapterModel) {
        self.chapter = chapter
    }
    
    deinit {
        print("vm deinit")
    }

    private func getChapterImages(data: [ChapterDetailModel]){
        let allObservables = data.map { RepoFactory.ChapterDetailRepo().getChapterImg(chapter: $0) }
        
        let all = Observable.from(allObservables).merge().toArray()
        
        let sortArray = all.asObservable().map { chapters in
            return chapters.sorted {
                $0.index ?? 0 < $1.index ?? 0
            }
        }
        
        sortArray.subscribe(onNext: { chapter in
            self.chapterDetail = chapter
            self.chapterImageSubject.onNext(chapter)
        })
        .disposed(by: bag)
    }
    
    func calulateImgHeight(index: Int, screenRatio: CGFloat, frameWidth: CGFloat) -> CGFloat {
        var ratio = 0.0
        if (index > 0 && index < chapterDetail.count) {
            let currentImage = chapterDetail[index].image
            if let imgHeight = currentImage?.size.height, let imgWidth = currentImage?.size.width {
                let imageCrop = imgWidth / imgHeight
                print(imageCrop)
                ratio = (frameWidth * (imageCrop < 0.4 ? 1.5 : imageCrop)) + screenRatio
            }
        }
        return ratio
    }
    
    func transform(input: Input) -> Output {
        
        input.getChapterDetail
            .asObservable()
            .flatMap { _ in
                return RepoFactory.ChapterDetailRepo().getDetailChapter(urlStrPath: self.chapter.chapterUrl ?? "")
            }
            .map({ data -> [ChapterDetailModel] in
                let results = SwiftSoupService.shared.getAllElements(document: data,
                                                                     className: "main div.reading-detail.box_doc div.page-chapter")
            
                
                let chapters: [ChapterDetailModel] = results?.map({ value -> ChapterDetailModel in
    
                    let img = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "img", attr: "data-original")
                    let dataIndex = SwiftSoupService.shared.getAttrFromHtml(element: value, className: "img", attr: "data-index")
                    return ChapterDetailModel(url: ChapterDetailModel.getUrlImg(img: img), dataIndex: dataIndex)
                }) ?? []
                
                return chapters
            })
            .subscribe(onNext: { data in
                self.getChapterImages(data: data)
            })
            .disposed(by: bag)
        
        // không thể deinit nếu sử dụng hàm được khởi tạo trong local, phải dùng weak self mới có thể deinit
//        getChapterImgSubject
//            .flatMap({ data in
//                return self.getChapterImages(data: data)
//            })
//            .subscribe(onNext: { data in
//                self.getChapterImages(data: data)
//                self.test()
//            })
//            .disposed(by: bag)

        let chapterImageOutput = chapterImageSubject.asDriver(onErrorJustReturn: [])
        
        return Output(chapterImageOutput: chapterImageOutput)
    }
}
