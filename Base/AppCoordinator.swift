//
//  AppCoordinator.swift
//  Base
//
//  Created by BaoHoang on 14/10/2022.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let tabbarController: UITabBarController
    private var homeCoor: HomeCoordinator?
    private var searchCoor: SearchCoordinator?
    private var categoryCoor: CategoryCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.tabbarController = UITabBarController()
    }

    func start() {
        // khởi tạo màn home
        let homeVC = HomeViewController()
        let homeVM = HomeViewModel(topComicUC: TopComicUC(repository: TopComicRepository()),
                                   coordinator: HomeCoordinator(navigator: navigationController))
        homeVC.bind(to: homeVM)
        homeVC.tabBarItem = UITabBarItem(title: L10n.Common.Tab.home, image: UIImage(asset: Asset.Images.Common.icHome), tag: 0)
        
        let searchVC = SearchViewController()
        let searchVM = SearchViewModel(searchUC: SearchUC(repository: SearchRepository()),
                                       coordinator: SearchCoordinator(navigator: navigationController))
        searchVC.bind(to: searchVM)
        searchVC.tabBarItem = UITabBarItem(title: L10n.Common.Tab.search, image: UIImage(asset: Asset.Images.Common.icSearch), tag: 1)

        let categoryVC = CategoryViewController()
        let categoryVM = CategoryViewModel(categoryUC: CategoryUC(repository: CategoryRepository()),
                                           coordinator: CategoryCoordinator(navigator: navigationController))
        categoryVC.bind(to: categoryVM)
        categoryVC.tabBarItem =  UITabBarItem(title: L10n.Common.Tab.category, image: UIImage(asset: Asset.Images.Common.icBook), tag: 2)
        
        let test3 = UINavigationController(rootViewController: UIViewController())
        test3.tabBarItem = UITabBarItem(title: L10n.Common.Tab.favorite, image: UIImage(asset: Asset.Images.Common.icHeart), tag: 3)

        tabbarController.viewControllers = [homeVC,
                                            searchVC,
                                            categoryVC,
                                            test3]
        
        navigationController.pushViewController(tabbarController, animated: true) // nếu có authen có thể check token ở đây, nếu có thì push vào login
//
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
}
