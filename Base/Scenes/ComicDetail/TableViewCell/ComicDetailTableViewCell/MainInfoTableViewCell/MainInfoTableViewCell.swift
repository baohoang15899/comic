//
//  MainInfoTableViewCell.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import UIKit

class MainInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        selectionStyle = .none
    }
    
    func configCell(data: ComicDetailMainInfoModel) {
        posterImageView.sd_setImage(with: URL(string: data.img ?? ""), completed: nil)
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.masksToBounds = true
        titleLabel.text = L10n.ComicDetail.title(data.title ?? "")
        statusLabel.text = L10n.ComicDetail.status(data.status ?? "")
        authorLabel.text = L10n.ComicDetail.author(data.author ?? "")
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
}
