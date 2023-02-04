//
//  ComicTableViewCell.swift
//  Base
//
//  Created by baohoang on 19/01/2023.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class ComicTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var behavior = MSCollectionViewPeekingBehavior()
    private var comics: [ComicModel] = []
    
    var didSelectComic: ((ComicModel) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.registerCell(type: ComicCollectionViewCell.self)
        behavior.cellPeekWidth = 10
        behavior.cellSpacing = 0
        behavior.numberOfItemsToShow = 3
        behavior.cellSpacing = 10
        collectionView.configureForPeekingBehavior(behavior: behavior)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: -16)
    }

    func configCell(data: [ComicModel]) {
        self.collectionView.reloadData()
        comics = data
    }
    
}

extension ComicTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.isEmpty ? 0 : Array(comics[0...9]).count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectComic?(comics[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ComicCollectionViewCell.self, forIndexPath: indexPath)
        let item = comics[indexPath.row]
        cell.comicBaseView.configView(comic: item)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
