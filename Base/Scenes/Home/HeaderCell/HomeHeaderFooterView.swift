//
//  HomeHeaderFooterView.swift
//  Base
//
//  Created by BaoHoang on 07/12/2022.
//

import Foundation
import UIKit

class HomeHeaderFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var weatherCelsiusLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func configHeader(data: HomeHeaderWeatherModel?) {
        cityNameLabel.text = data?.cityName ?? ""
        weatherStatusLabel.text = data?.status ?? ""
        weatherCelsiusLabel.text = "\(data?.celsius ?? "0")°"
    }
    
}
