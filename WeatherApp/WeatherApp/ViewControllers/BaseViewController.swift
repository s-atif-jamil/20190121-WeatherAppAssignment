//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/19/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    

    // MARK: - Helper Methods
    func showError(_ error: Error?) -> Bool {
        guard let error = error else { return false }
        let alert = UIAlertController(title: "WeatherApp", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        return true
    }


    // MARK: - Action Handler
    
    @IBAction func actionClose(_ sender: Any) {
        if  self.navigationController != nil {
            self.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
