//  ComicDetailCoordinator.swift
//  Base
//
//  Created by baohoang on 20/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import Foundation
import UIKit

// khai báo các phương thức điều hướng
protocol ComicDetailRoutes: AnyObject {
    func navigateToChapterDetail(chapter: ChapterModel)
}

class ComicDetailCoordinator: Coordinator {
   
    private var navigator: UINavigationController
    private let comicUrl: String
    private let title: String
//    private var ex1Coordinator: Example1Coordinator? // khai báo coordinator cần đổi nếu có

    init(navigator: UINavigationController, comicDetailUrl: String, title: String) {
        self.navigator = navigator
        self.comicUrl = comicDetailUrl
        self.title = title
    }
    
    // khởi tạo màn và điều hướng
    func start() {
        let comicDetailVC = ComicDetailViewController()
        let comicDetailVM = ComicDetailViewModel(detailComicUrl: comicUrl,
                                                 comicDetailUC: ComicDetailUC(repository: ComicDetailRepository()))
        comicDetailVC.routesDelegate = self // gán delegate cho view contoller quản lý route nếu có
        comicDetailVC.bind(to: comicDetailVM)
        comicDetailVC.hidesBottomBarWhenPushed = true
        comicDetailVC.title = title
        navigator.pushViewController(comicDetailVC, animated: true)
    }
}

// logic các phương thức điều hướng
extension ComicDetailCoordinator: ComicDetailRoutes {
    // chuyển coordinator thì làm như dưới, điều hướng các màn thuộc coordinator thì push bình thường
    func navigateToChapterDetail(chapter: ChapterModel) {
        let chapterDetailVC = ChapterDetailViewController()
        let chapterDetailVM = ChapterDetailViewModel(chapter: chapter, chapterDetailUC: ChapterDetailUC(repository: ChapterDetailRepository()))
        chapterDetailVC.bind(to: chapterDetailVM)
        chapterDetailVC.hidesBottomBarWhenPushed = true
        navigator.pushViewController(chapterDetailVC, animated: true)
    }
    
}
