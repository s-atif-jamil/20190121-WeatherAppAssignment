//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit
import MapKit

class AddCityViewController: BaseViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var searchBar: UISearchBar!
    
    var pinAnnotation = MKPointAnnotation()
    var selectedCity: City!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(actionTap(_:)))
        self.mapView.addGestureRecognizer(gestureRecognizer)
        self.mapView.addAnnotation(pinAnnotation)
        self.centerMap(on: self.mapView.userLocation.coordinate)
    }
    
    
    // MARK: - Action Handlers
    
    @IBAction func actionTap(_ gestureReconizer: UILongPressGestureRecognizer) {

        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)

        pinAnnotation.coordinate = coordinate
        pinAnnotation.title = "Loading..."
        ApiManager.requestTodayForcast(city: City("", coordinate.latitude, coordinate.longitude)) { [weak self] (city, error) in
            guard self != nil else { return }
            self!.pinAnnotation.title = city?.name
            self!.selectedCity = city
        }
    }
    
    @IBAction func actionDone(_ sender: Any) {
        guard let city = selectedCity else { return }
        
        AppData.shared.cityList.append(city)
        AppData.shared.saveBookmarkCityList()
        actionClose(sender)
    }
    
}


// MARK: - MKMapViewDelegate

extension AddCityViewController: MKMapViewDelegate {
    
    func centerMap(on coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 5000
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius), animated: true)
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMap(on: userLocation.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView?.tintColor = .green
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotation = views.first(where: { $0.reuseIdentifier == "pin" })?.annotation {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard view.annotation === pinAnnotation else { return }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            mapView.selectAnnotation(self.pinAnnotation, animated: false)
        }
    }
}


// MARK: - UISearchBarDelegate

extension AddCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        ApiManager.requestTodayForcast(query: searchBar.text ?? "") { [weak self] (city, error) in
            guard self != nil else { return }
            guard self!.showError(error) == false else { return }
            guard let city = city else { return }
            
            let coordinate = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
            self!.pinAnnotation.coordinate = coordinate
            self!.pinAnnotation.title = city.name
            self!.selectedCity = city
            self!.centerMap(on: coordinate)
        }
    }
    
}
