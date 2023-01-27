//
//  AppCoordinator.swift
//  Base
//
//  Created by BaoHoang on 14/10/2022.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let tabbarController: UITabBarController
    private var homeCoor: HomeCoordinator?
    private var searchCoor: SearchCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.tabbarController = UITabBarController()
    }

    func start() {
        window.rootViewController = self.navigationController
        
        // khởi tạo màn home
        let homeNavigationContoller = UINavigationController()
        homeNavigationContoller.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        self.homeCoor = HomeCoordinator(navigator: homeNavigationContoller)
        homeCoor?.start()
        
        let searchNavigationContoller = UINavigationController()
        searchNavigationContoller.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        self.searchCoor = SearchCoordinator(navigator: searchNavigationContoller)
        searchCoor?.start()
        
        let test2 = UINavigationController(rootViewController: UIViewController())
        test2.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        
        let test3 = UINavigationController(rootViewController: UIViewController())
        test3.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)

        tabbarController.setViewControllers( [homeNavigationContoller, searchNavigationContoller, test2 ,test3], animated: false)
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(tabbarController, animated: true) // nếu có authen có thể check token ở đây, nếu có thì push vào login
//
        window.makeKeyAndVisible()
    }
}
