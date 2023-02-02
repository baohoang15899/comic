//
//  ComicCategoryTableViewCell.swift
//  Base
//
//  Created by BaoHoang on 01/02/2023.
//

import UIKit

class ComicCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newChapterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicImageView.image = nil
        titleLabel.text = nil
        newChapterLabel.text = nil
    }
    
    func configCell(data: ComicModel) {
        comicImageView.sd_setImage(with: URL(string: data.image ?? ""))
        comicImageView.layer.cornerRadius = 10
        comicImageView.layer.masksToBounds = true
        titleLabel.text = data.title
        newChapterLabel.text = data.newChapter
    }
    
}
