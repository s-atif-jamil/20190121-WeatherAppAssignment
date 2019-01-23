//
//  WeatherInfoCollectionCell.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/20/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class WeatherInfoCollectionCell: BaseCollectionViewCell {
    
    @IBOutlet var dateInfoLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var model: ForecastGroup! {
        didSet {
            self.dateInfoLabel.text = model.dateInfo
            self.tableView.reloadData()
        }
    }
    
}

extension WeatherInfoCollectionCell: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.details.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoDetailTableCell.identifier, for: indexPath) as! WeatherInfoDetailTableCell
        cell.model = model.details[indexPath.row]
        return cell
    }
    
}
