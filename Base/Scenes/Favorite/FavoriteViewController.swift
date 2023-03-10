//  FavoriteViewController.swift
//  Base
//
//  Created by BaoHoang on 09/02/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FavoriteViewController: BaseViewController<FavoriteViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabbarHeaderBaseView: TabbarHeaderBaseView!
    @IBOutlet weak var stackEmptyView: UIStackView!
    @IBOutlet weak var emptyContentLabel: UILabel!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotificationCenter()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    deinit {
        print("FavoriteViewController deinit ✅")
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateFavorite),
                                               name: NSNotification.Name(NotificationCenterKey.favorite),
                                               object: nil)
    }
    
    private func setupUI() {
        tabbarHeaderBaseView.configView(title: L10n.Common.Tab.favorite)
        tableView.sectionFooterHeight = 0.01
        tableView.sectionHeaderHeight = 0.01
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.registerCell(type: ComicSuggestTableViewCell.self)
        emptyTitleLabel.text = L10n.Favorite.Empty.title
        emptyContentLabel.text = L10n.Favorite.Empty.content
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        emptyContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    @objc private func updateFavorite() {
        viewModel.getAllFavoriteSubject.onNext(())
    }
    
    override func bindViewModel() {
        let input = FavoriteViewModel.Input(getAllFavorite: Driver.just(()),
                                            didSelectItem: tableView.rx.modelSelected(FavoriteComicItemModel.self).asDriver())
        let output = viewModel.transform(input: input)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<FavoriteComicSection>(
            
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .fade),
            
            configureCell: { (dataSource, tableView, indexPath, item) in
                let cell = tableView.dequeueReusableCell(type: ComicSuggestTableViewCell.self, forIndexPath: indexPath)
                let data = ComicSuggestModel(image: item.image ?? "",
                                             title: item.title ?? "",
                                             category: item.category ?? "",
                                             chapter: item.chapter ?? "",
                                             detailUrl: item.detailUrl ?? "")
                cell.configCell(data: data)
                return cell
            },
            canEditRowAtIndexPath: { (dataSource, IndexPath) in
                return true
            }
            
        )
        
        output.comicSuggestIsEmpty
            .drive(stackEmptyView.rx.isHidden)
            .disposed(by: bag)
        
        output.favoriteComic
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completion) in
            self?.viewModel.deleteItemSubject.onNext(indexPath)
            completion(true)
        }
        
        deleteAction.image = Asset.Images.Favorite.icTrash.image
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
