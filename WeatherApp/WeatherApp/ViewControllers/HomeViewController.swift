//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/20/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var placeholderLabel: UILabel!
    
    var cityList: [City] = AppData.shared.cityList
    var shouldRequestWeatherOfAllCities: Bool = false
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if cityList.count == 0 {
            self.requestCurrentCity()
        } else {
            self.requestWeatherOfAllCitiy()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAppMeasureSytemChanged(_:)), name: NSNotification.Name.AppMeasureSytemChanged, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cityList = AppData.shared.cityList
        self.tableView.reloadData()
        if self.shouldRequestWeatherOfAllCities {
            self.requestWeatherOfAllCitiy()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.setEditing(false, animated: animated)
    }
    
    
    // MARK: - Action Handlers
    
    @IBAction func actionEdit(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
    
    // MARK: - Helper Methods
    
    func requestCurrentCity() {
        LocationManager.getCurrentLocation { (location, error) in
            guard self.showError(error) == false else { return }
            guard let location = location else { return }

            let city = City("", location.coordinate.latitude, location.coordinate.longitude)
            ApiManager.requestTodayForcast(city: city, { (city, error) in
                guard self.showError(error) == false else { return }
                guard let city = city else { return }

                self.cityList.append(city)
                self.tableView.reloadData()
                AppData.shared.cityList = self.cityList
                AppData.shared.saveBookmarkCityList()
            })
        }
    }
    
    func requestWeatherOfAllCitiy() {
        for city in cityList {
            ApiManager.requestTodayForcast(city: city) { (city, error) in
                guard self.showError(error) == false else { return }
                guard let city = city else { return }
                guard let index = self.cityList.firstIndex(of: city) else { return }
                self.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: UITableView.RowAnimation.fade)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? CityViewController,
            let cell = sender as? CityWeatherTableCell {
            destination.city = cell.model
        }
    }

    
    // MARK: - Notification Handlers

    @objc func notificationAppMeasureSytemChanged(_ notification: Notification) {
        self.shouldRequestWeatherOfAllCities = true
    }

}


// MARK: - UITableView Datasource & Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = (cityList.count == 0)
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherTableCell.identifier, for: indexPath) as! CityWeatherTableCell
        cell.model = cityList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            AppData.shared.cityList = cityList
            AppData.shared.saveBookmarkCityList()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let city = cityList.remove(at: sourceIndexPath.row)
        cityList.insert(city, at: destinationIndexPath.row)
        AppData.shared.cityList = cityList
        AppData.shared.saveBookmarkCityList()
    }
}
