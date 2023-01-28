//
//  ComicSuggestTableViewCell.swift
//  Base
//
//  Created by BaoHoang on 27/01/2023.
//

import UIKit

class ComicSuggestTableViewCell: UITableViewCell {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        selectionStyle = .none
    }
    
    func configCell(data: ComicSuggestModel) {
        comicImageView.sd_setImage(with: URL(string: data.image ?? ""))
        titleLabel.text = data.title
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        chapterLabel.text = data.chapter
        categoryLabel.text = data.category
        comicImageView.layer.cornerRadius = 10
        comicImageView.layer.masksToBounds = true
    }
    
}
