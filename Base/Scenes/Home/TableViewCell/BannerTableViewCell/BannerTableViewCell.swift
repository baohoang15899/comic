//
//  BannerTableViewCell.swift
//  Base
//
//  Created by baohoang on 20/01/2023.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    private var comics: [ComicModel] = []
    
    private var currentIndex = 0
    private var timer: Timer?
    
    var didSelectComic: ((ComicModel) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        autoScroll()
    }

    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(type: BannerCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        selectionStyle = .none
    }
    
    private func autoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    func configCell(data: [ComicModel]) {
        comics = data.isEmpty ? [] : Array(data[0...5])
        bannerPageControl.numberOfPages = comics.count
    }
    
    @objc func slideToNext() {
        if (currentIndex < comics.count - 1) {
            currentIndex = currentIndex + 1
        } else {
            currentIndex = 0
        }
        bannerPageControl.currentPage = currentIndex
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }
    
}

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        bannerPageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectComic?(comics[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: BannerCollectionViewCell.self, forIndexPath: indexPath)
        let item = comics[indexPath.row]
        cell.configCell(data: item)
        return cell
    }
}
