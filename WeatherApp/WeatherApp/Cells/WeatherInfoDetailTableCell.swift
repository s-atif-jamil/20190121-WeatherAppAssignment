//
//  WeatherInfoDetailTableCell.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/20/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class WeatherInfoDetailTableCell: BaseTableViewCell {

    @IBOutlet var timeInfoLabel: UILabel!
    @IBOutlet var weatherInfoLabel: UILabel!
    @IBOutlet var humidityInfoLabel: UILabel!
    @IBOutlet var rainInfoLabel: UILabel!
    @IBOutlet var windInfoLabel: UILabel!
    @IBOutlet var tempratureLabel: UILabel!
    @IBOutlet var weathreImageView: UIImageView!

    var model: ForecastDetail! {
        didSet {
            self.timeInfoLabel.text = model.timeInfo
            self.weatherInfoLabel.text = model.weatherInfo
            self.rainInfoLabel.text = model.rainInfo
            self.windInfoLabel.text = model.windInfo
            self.humidityInfoLabel.text = String(format: "Humidity: %.0f%%", model.humidity)
            self.tempratureLabel.text = String(format: "%.0f°", model.temprature)
            self.weathreImageView.downloaded(from: model.imageLink, placeholder: UIImage(named: "Placeholder"))
        }
    }

}
