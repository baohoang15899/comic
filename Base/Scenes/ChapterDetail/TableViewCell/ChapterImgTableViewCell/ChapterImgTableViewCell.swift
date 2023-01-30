//
//  ChapterImgTableViewCell.swift
//  Base
//
//  Created by baohoang on 23/01/2023.
//

import UIKit

class ChapterImgTableViewCell: UITableViewCell {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chapterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        chapterImageView.image = nil
    }

    private func setupUI() {
        selectionStyle = .none
    }

    func configCell(data: UIImage, quality: JPEGQuality) {
        if let image = data.jpeg(quality) {
            chapterImageView.image = UIImage(data: image)
        }
    }
    
}
