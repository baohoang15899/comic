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
    @IBOutlet weak var wrapperView: UIView!
    
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
        if #available(iOS 13.0, *) {
            wrapperView.backgroundColor = (data.isRead ?? false) ? .lightGray.withAlphaComponent(0.2) : .systemBackground
        } else {
            // Fallback on earlier versions
            wrapperView.backgroundColor = (data.isRead ?? false) ? .lightGray.withAlphaComponent(0.2) : .white
        }
    }
    
}
