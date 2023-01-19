//
//  ComicBaseView.swift
//  Base
//
//  Created by baohoang on 19/01/2023.
//

import Foundation
import UIKit
import SDWebImage

class ComicBaseView: XibView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configView(comic: ComicModel) {
        imageView.sd_setImage(with: URL(string: comic.image ?? ""), completed: nil)
        imageView.layer.cornerRadius = 10
        titleLabel.text = comic.title ?? ""
        imageView.layer.masksToBounds = true
    }
    
}
