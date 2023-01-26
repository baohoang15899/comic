//
//  ContentTableViewCell.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        selectionStyle = .none
    }
    
    func configCell(data: ComicDetailContentModel) {
        contentLabel.text = data.content ?? ""
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
}
