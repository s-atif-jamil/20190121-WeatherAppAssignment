//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {

    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var callback: ((CLLocation?, Error?) -> ())? = nil
    
    /// Initiallize and set CLLocationManager delegate
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    /// This is the main method for getting the users location and will pass back
    /// the usersLocation when it is available
    ///
    /// - Parameter callback: callback will be executed once the location found
    static func getCurrentLocation(_ callback: @escaping ((CLLocation?, Error?) -> ())) {
        
        shared.callback = callback
        
        //First need to check if the apple device has location services availabel. (i.e. Some iTouch's don't have this enabled)
        if CLLocationManager.locationServicesEnabled() {
            //Then check whether the user has granted you permission to get his location
            if CLLocationManager.authorizationStatus() == .notDetermined {
                //Request permission
                //Note: you can also ask for .requestWhenInUseAuthorization
                shared.manager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied {
                //... Sorry for you. You can huff and puff but you are not getting any location
                shared.callback?(nil, NSError(appError: .locationError))
            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                // This will trigger the locationManager:didUpdateLocation delegate method to get called when the next available location of the user is available
                shared.manager.startUpdatingLocation()
            }
        }
        
    }
}


// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Because multiple methods might have called getlocationForUser: method there might me multiple methods that need the users location.
        //These userLocation closures will have been stored in the locationManagerClosures array so now that we have the users location we can pass the users location into all of them and then reset the array.
        if let location = locations.first {
            self.callback?(location, nil)
        } else {
            self.callback?(nil, NSError(appError: .locationError))
        }

        self.callback = nil
        self.manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.callback?(nil, error)
        self.callback = nil
        self.manager.stopUpdatingLocation()
    }

}
