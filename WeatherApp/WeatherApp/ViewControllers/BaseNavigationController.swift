//
//  BaseNavigationController.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/20/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.all }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.barStyle = .default
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = UIColor.darkGray
        self.navigationBar.tintColor = UIColor.darkGray
        self.navigationBar.setBackgroundImage(UIImage() , for: .default)
    }

}
