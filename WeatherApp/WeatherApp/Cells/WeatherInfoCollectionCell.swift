//
//  WeatherInfoCollectionCell.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/20/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class WeatherInfoCollectionCell: BaseCollectionViewCell {
    
}

extension WeatherInfoCollectionCell: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: WeatherInfoDetailTableCell.identifier, for: indexPath)
    }
    
}
