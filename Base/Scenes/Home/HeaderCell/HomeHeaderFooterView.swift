//
//  HomeHeaderFooterView.swift
//  Base
//
//  Created by BaoHoang on 07/12/2022.
//

import Foundation
import UIKit

class HomeHeaderFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionLabel: UILabel!
    
    func configHeader(title: String) {
        sectionLabel.text = title
        sectionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
}
