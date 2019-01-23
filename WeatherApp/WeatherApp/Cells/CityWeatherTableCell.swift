//
//  CityWeatherTableCell.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/20/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class CityWeatherTableCell: BaseTableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var weatherInfoLabel: UILabel!
    @IBOutlet var tempratureLabel: UILabel!
    @IBOutlet var weathreImageView: UIImageView!
    
    var model: City! {
        didSet {
            self.nameLabel.text = model.name
            self.weatherInfoLabel.text = model.weatherInfo
            self.tempratureLabel.text = String(format: "%.0f°", model.temprature)
            self.weathreImageView.downloaded(from: model.imageLink, placeholder: UIImage(named: "Placeholder"))
        }
    }

}
