//
//  BaseTableViewCell.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/19/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

}
