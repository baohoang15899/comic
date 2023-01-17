//  HomeCoordinator.swift
//  Base
//
//  Created by BaoHoang on 15/10/2022.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import Foundation
import UIKit

// khai báo các phương thức điều hướng
protocol HomeRoutes: AnyObject {
    func navigateExample1()
}

class HomeCoordinator: Coordinator {
   
    private var navigator: UINavigationController
//    private var ex1Coordinator: Example1Coordinator? // khai báo coordinator cần đổi nếu có

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    // khởi tạo màn và điều hướng
    func start() {
        let homeVC = HomeViewController()
        let homeVM = HomeViewModel()
        homeVC.routesDelegate = self // gán delegate cho view contoller quản lý route nếu có
        homeVC.bind(to: homeVM)
        navigator.pushViewController(homeVC, animated: true)
    }
}

// logic các phương thức điều hướng
extension HomeCoordinator: HomeRoutes {
    // chuyển coordinator thì làm như dưới, điều hướng các màn thuộc coordinator thì push bình thường
    func navigateExample1() {
//        let ex1Coordinator = Example1Coordinator(navigator: navigator)
//        ex1Coordinator.start()
//        self.ex1Coordinator = ex1Coordinator
    }
    
}
