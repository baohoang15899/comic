//  ComicDetailViewController.swift
//  Base
//
//  Created by baohoang on 20/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ComicDetailViewController: BaseViewController<ComicDetailViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<ComicDetailSectionData>? = nil
    private var heartButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    deinit {
        print("ComicDetailViewController deinit ✅")
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        heartButton.tintColor = .red
        heartButton.image = Asset.Images.ComicDetail.icHeartGray.image
        heartButton.style = .plain
        navigationItem.rightBarButtonItem = heartButton
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.registerHeaderFooterView(type: BaseSectionHeaderFooterView.self)
        tableView.registerCell(type: MainInfoTableViewCell.self)
        tableView.registerCell(type: ContentTableViewCell.self)
        tableView.registerCell(type: ChapterTableViewCell.self)
        tableView.registerCell(type: CategoryTableViewCell.self)
        tableView.sectionFooterHeight = 0.01
        tableView.sectionHeaderHeight = 0.01
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 300
    }

    override func bindViewModel() {
        let input = ComicDetailViewModel.Input(getComicDetail: Driver.just(()),
                                               setFavorite: heartButton.rx.tap.asDriver(),
                                               getFavoriteStatus: Driver.just(()))
        let output = viewModel.transform(input: input)
        
        dataSource = RxTableViewSectionedReloadDataSource<ComicDetailSectionData>(
            
            configureCell: { datasource, tableView, indexPath, item in
                switch datasource[indexPath.section].type {
                    
                case .info:
                    let cell = tableView.dequeueReusableCell(type: MainInfoTableViewCell.self, forIndexPath: indexPath)
                    let data = item as? ComicDetailMainInfoModel
                    if let data = data {
                        cell.configCell(data: data)
                    }
                    return cell
                
                case .category:
                    let cell = tableView.dequeueReusableCell(type: CategoryTableViewCell.self, forIndexPath: indexPath)
                    let data = item as? ComicDetailCategoryModel
                    if let data = data {
                        cell.configCell(data: data.categories ?? [])
                    }
                    return cell
                    
                case .content:
                    let cell = tableView.dequeueReusableCell(type: ContentTableViewCell.self, forIndexPath: indexPath)
                    let data = item as? ComicDetailContentModel
                    if let data = data {
                        cell.configCell(data: data)
                    }
                    return cell
                    
                case .chapter:
                    let cell = tableView.dequeueReusableCell(type: ChapterTableViewCell.self, forIndexPath: indexPath)
                    let data = item as? ComicDetailChapterModel
                    if let data = data, let chapter = data.chapter {
                        cell.configCell(data: chapter)
                    }
                    return cell
                    
                }
            }
        )
        
        if let dataSource = dataSource {
            output.comicDetailSection
                .drive(tableView.rx.items(dataSource: dataSource))
                .disposed(by: bag)
        }
        
        Driver.merge(output.setFavoriteStatus, output.getFavoriteStatus)
            .drive {[weak self] status in
                self?.heartButton.image = status ? Asset.Images.ComicDetail.icHeartFill.image : Asset.Images.ComicDetail.icHeartGray.image
            }
            .disposed(by: bag)
    }
}

extension ComicDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch dataSource?[section].type {
        case .info:
            return UITableViewHeaderFooterView()
        default:
            let header = self.tableView.dequeueReusableHeaderFooterView(type: BaseSectionHeaderFooterView.self)
            header.configHeader(title: dataSource?[section].header ?? "")
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (dataSource?[indexPath.section].type == .chapter) {
            if let item = dataSource?[indexPath.section].items[indexPath.row] {
                let data = item as? ComicDetailChapterModel
                if let chapter = data?.chapter {
                    viewModel.didSelectItem.onNext(chapter)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource?[section].type {
        case .info:
            return 1
        default:
            return 40
        }
    }
    
    
}
