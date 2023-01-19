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
        // Initialization code
    }
    
    func configCell(data: ComicModel) {
        imageView.sd_setImage(with: URL(string: data.image ?? ""), completed: nil)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }

}
