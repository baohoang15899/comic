//
//  CategoryCollectionViewCell.swift
//  Base
//
//  Created by baohoang on 22/01/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(title: String) {
        categoryLabel.text = title
        wrapperView.layer.cornerRadius = 10
    }

}
