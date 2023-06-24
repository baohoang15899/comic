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
        window.rootViewController = self.navigationController
        
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
        
        let favoriteVC = FavoriteViewController()
        let favoriteVM = FavoriteViewModel(favoriteUC: FavoriteUC(favoriteRepository: FavoriteRepository()), coordinator: FavoriteCoordinator(navigator: navigationController))
        favoriteVC.bind(to: favoriteVM)
        favoriteVC.tabBarItem = UITabBarItem(title: L10n.Common.Tab.favorite, image: UIImage(asset: Asset.Images.Common.icHeart), tag: 3)
        
        let settingVC = SettingViewController()
        let settingVM = SettingViewModel()
        settingVC.bind(to: settingVM)
        settingVC.tabBarItem = UITabBarItem(title: L10n.Setting.title, image: UIImage(asset: Asset.Images.ComicDetail.icComicDetailSetting), tag: 4)

        tabbarController.setViewControllers([homeVC,
                                             searchVC,
                                             categoryVC,
                                             favoriteVC,
                                             settingVC], animated: true)
        
        if #available(iOS 13.0, *) {
            navigationController.view.backgroundColor = UIColor.systemBackground
        } else {
            navigationController.view.backgroundColor = UIColor.white
        }
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(tabbarController, animated: true) // nếu có authen có thể check token ở đây, nếu có thì push vào login
//
        window.makeKeyAndVisible()
    }
}
