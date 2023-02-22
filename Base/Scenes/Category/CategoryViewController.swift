//  CategoryViewController.swift
//  Base
//
//  Created by BaoHoang on 31/01/2023.
//  Copyright (c) baohg. All rights reserved.
//
//  This file was generated by the Educa MVVM-C Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  Template created by baohg - bao15899@gmail.com

import UIKit
import RxSwift
import RxCocoa

class CategoryViewController: BaseViewController<CategoryViewModel> {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var pickerViewToolBar: UIToolbar!
    @IBOutlet weak var wrapperPickerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBarHeaderBaseView: TabbarHeaderBaseView!
    @IBOutlet weak var stackEmptyView: UIStackView!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyContentLabel: UILabel!
    
    private let refreshControl = UIRefreshControl()
    private let bag = DisposeBag()
    private let submitButton: UIBarButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        print("CategoryViewController deinit ✅")
    }
    
    private func setupUI() {
        tableView.registerCell(type: ComicCategoryTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tabBarHeaderBaseView.configView(title: L10n.Category.title)
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl
        categoryButton.layer.cornerRadius = 10
        setupPickerView()
        emptyTitleLabel.text = L10n.Home.Empty.title
        emptyContentLabel.text = L10n.Home.Empty.content
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        emptyContentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    private func setupPickerView() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel: UIBarButtonItem = UIBarButtonItem(title: L10n.Common.cancel, style: .done, target: self, action: #selector(self.hidePickerView))
        submitButton.title = L10n.Common.done
        pickerViewToolBar.items = [cancel, flexSpace, submitButton]
        wrapperPickerView.alpha = 0.0
    }
    
    override func bindViewModel() {
        let input = CategoryViewModel.Input(willDisplayCell: tableView.rx.willDisplayCell.asDriver(),
                                            didSelectedItem: categoryPickerView.rx.itemSelected.asDriver(),
                                            didSelectedComic: tableView.rx.modelSelected(ComicModel.self).asDriver(),
                                            getAllCategory: Driver.just(()),
                                            onTapPickerView: submitButton.rx.tap.asDriver(),
                                            pullToRefresh: refreshControl.rx.controlEvent(.valueChanged).asDriver())
        let output = viewModel.transform(input: input)
        
        output.allComic
            .drive(tableView.rx.items) {tableView, index, data in
                let cell = tableView.dequeueReusableCell(type: ComicCategoryTableViewCell.self,
                                                         forIndexPath: IndexPath.init(row: index, section: 0))
                cell.configCell(data: data)
                return cell
            }
            .disposed(by: bag)
        
        output.allCategory
            .drive(categoryPickerView.rx.itemTitles) { (row, element) in
                return element.title ?? ""
            }
            .disposed(by: bag)
        
        output.categoryTitle
            .drive(categoryButton.rx.title(for: .normal))
            .disposed(by: bag)
        
        output.pickerViewSubmit
            .drive { _ in
                self.hidePickerView()
            }
            .disposed(by: bag)
        
        output.isRefresing
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: bag)
        
        output.isEmpty
            .drive(stackEmptyView.rx.isHidden)
            .disposed(by: bag)
        
    }
    
    @IBAction func onTap(_ sender: Any) {
        showPickerView()
    }
    
    @objc func hidePickerView() {
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.wrapperPickerView.alpha = 0
        }, completion: nil)
    }
    
    @objc func showPickerView() {
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            self.wrapperPickerView.alpha = 1
        }, completion: nil)
    }
}

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
