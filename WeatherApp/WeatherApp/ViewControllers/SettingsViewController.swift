//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet var measureButtons: [UIButton]!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.measureButtons.forEach { $0.isSelected = ($0.tag == AppData.shared.measureSystem.tag) }
    }
    
    
    // MARK: - Action Handlers
    
    @IBAction func actionMeasureSystem(_ sender: UIButton) {
        measureButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        AppData.shared.measureSystem = (sender.tag == MeasureSystem.imperial.tag ? .imperial : .metric)
    }
    
    @IBAction func actionDeleteCityList(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm", message: "Are you sure to delete all bookmark cities?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            AppData.shared.cityList = []
            AppData.shared.saveBookmarkCityList()
        }))
        
        present(alert, animated: true, completion: nil)
    }

}
