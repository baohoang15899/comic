//  HomeViewController.swift
//  Base
//
//  Created by BaoHoang on 15/10/2022.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController<HomeViewModel> {

    private let bag = DisposeBag()
    weak var routesDelegate: HomeRoutes?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        print("HomeViewController deinit ✅")
    }
    
    private func setupUI() {
//        tableView.contentInsetAdjustmentBehavior = .never // show content de` len status bar cua tableview len superview
        tableView.registerHeaderFooterView(type: HomeHeaderFooterView.self)
        tableView.sectionFooterHeight = 0.01
        tableView.sectionHeaderHeight = 0.01
//        tableView.delegate = self
    }
    
    override func bindViewModel() {
        let input = HomeViewModel.Input(getHotComic: Driver.just(()),
                                        getTopMonth: Driver.just(()),
                                        getTopWeek: Driver.just(()),
                                        getTopDay: Driver.just(())
        )
        let output = viewModel.transform(input: input)
        
        output.hotComic
            .drive { data in
                print("my data \(data)")
            }
            .disposed(by: bag)
    }
}

//extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerCell = tableView.dequeueReusableHeaderFooterView(type: HomeHeaderFooterView.self)
//        viewModel.headerWeatherDataSubject.subscribe(onNext: {[weak self] data in
//            headerCell.configHeader(data: data)
//            self?.tableView.reloadData()
//            self?.view.setNeedsLayout()
//        })
//        .disposed(by: bag)
//        return headerCell
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 300 // sử dụng height auto phải set estimate height bằng hoặc lớn hơn height theo design
//    }
//}
