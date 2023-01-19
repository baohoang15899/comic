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
import RxDataSources

class HomeViewController: BaseViewController<HomeViewModel> {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: TabbarHeaderBaseView!
    
    weak var routesDelegate: HomeRoutes?
    
    private let bag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<HomeSectionData>? = nil
    
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
        tableView.registerHeaderFooterView(type: HomeHeaderFooterView.self)
        tableView.registerCell(type: ComicTableViewCell.self)
        tableView.registerCell(type: BannerTableViewCell.self)
        tableView.sectionFooterHeight = 0.01
        tableView.sectionHeaderHeight = 0.01
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        headerView.configView(title: L10n.Home.tab)
    }
    
    override func bindViewModel() {
        let input = HomeViewModel.Input(getHotComic: Driver.just(()),
                                        getTopMonth: Driver.just(()),
                                        getTopWeek: Driver.just(()),
                                        getTopDay: Driver.just(()),
                                        getNominate: Driver.just(())
        )
        let output = viewModel.transform(input: input)
        
        dataSource = RxTableViewSectionedReloadDataSource<HomeSectionData>(
            
            configureCell: { datasource, tableView, indexPath, item in
                switch datasource[indexPath.section].type {
        
                case .normal:
                    let cell = tableView.dequeueReusableCell(type: ComicTableViewCell.self, forIndexPath: indexPath)
                    cell.configCell(data: item.data ?? [])
                    return cell
                    
                case .banner:
                    let cell = tableView.dequeueReusableCell(type: BannerTableViewCell.self, forIndexPath: indexPath)
                    cell.configCell(data: item.data ?? [])
                    return cell
                    
                }

            }
        )
        
        if let dataSource = dataSource {
            output.homeSection
                .drive(tableView.rx.items(dataSource: dataSource))
                .disposed(by: bag)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource?[indexPath.section].type {
        case .normal:
            return 200
        case .banner:
            return 300
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterView(type: HomeHeaderFooterView.self)
        header.configHeader(title: dataSource?[section].header ?? "")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}
