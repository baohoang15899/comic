//
//  ChapterTableViewCell.swift
//  Base
//
//  Created by baohoang on 21/01/2023.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {

    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        selectionStyle = .none
    }
    
    func configCell(data: ChapterModel) {
        chapterLabel.text = data.title ?? ""
        dateLabel.text = data.date ?? ""
    }
    
}
