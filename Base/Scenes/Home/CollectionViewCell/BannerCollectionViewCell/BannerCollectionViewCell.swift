//
//  BannerCollectionViewCell.swift
//  Base
//
//  Created by baohoang on 20/01/2023.
//

import UIKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setGradientBackground()
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = UIColor.black.withAlphaComponent(0.9).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.3, 0.8]
        gradientLayer.frame = self.contentView.bounds
                
        self.imageView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func configCell(data: ComicModel) {
        imageView.sd_setImage(with: URL(string: data.image ?? ""), completed: nil)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }

}
