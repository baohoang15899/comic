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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupUI() {
        selectionStyle = .none
    }

    func configCell(data: Data) {
        chapterImageView.image = UIImage(data: data)
    }
    
}
