//
//  TabbarHeaderBaseView.swift
//  Base
//
//  Created by baohoang on 19/01/2023.
//

import Foundation
import UIKit

class TabbarHeaderBaseView: XibView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configView(title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
    }
    
}
