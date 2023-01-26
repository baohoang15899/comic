//
//  CategoryTableViewCell.swift
//  Base
//
//  Created by baohoang on 22/01/2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    private var categories: [String] = ["Hành động, Vui nhộn", "Kinh dị", "Hài hước", "Học đường", "Hành động, Vui nhộn", "Kinh dị", "Hài hước", "Học đường", "Hành động, Vui nhộn", "Kinh dị", "Hài hước", "Học đường", "Hành động, Vui nhộn", "Kinh dị", "Hài hước", "Học đường", "Hành động, Vui nhộn", "Kinh dị", "Hài hước", "Học đường", "Hành động, Vui nhộn", "Kinh dị", "Hài hước", "Học đường"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        updateCollectionViewHeight()
    }
    
    // trả về size tối ưu nhất cho collection view, ở đây chính là content size của collection view
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
            self.collectionView.layoutIfNeeded()
            self.layoutIfNeeded()
            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            return CGSize(width: contentSize.width, height: contentSize.height + 16) // 16 là padding bottom của collection view
        }
    
    private func setupUI() {
        selectionStyle = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(type: CategoryCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        
        let layout = LeftAlignCollectionViewCellFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.allowsMultipleSelection = true
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    func configCell(data: [String]) {
        categories = data
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(categories[indexPath.row])
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: CategoryCollectionViewCell.self, forIndexPath: indexPath)
        let item = categories[indexPath.row]
        cell.configCell(title: item)
        return cell
    }
}
