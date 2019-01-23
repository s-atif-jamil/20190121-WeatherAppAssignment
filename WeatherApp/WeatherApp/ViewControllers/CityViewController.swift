//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/20/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class CityViewController: BaseViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    var city: City!

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = city.name
        ApiManager.request5DaysForcast(city: city) { (city, error) in
            guard self.showError(error) == false else { return }
            self.collectionView.reloadData()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let offsetX = size.width * CGFloat(round(collectionView.contentOffset.x / collectionView.contentSize.width))
        coordinator.animate(alongsideTransition: nil) { _ in
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        }
    }
    
    
    // MARK: - Action Handlers
    
    @IBAction func actionPageChanged(_ sender: Any) {
        let x = self.collectionView.bounds.width * CGFloat(self.pageControl.currentPage)
        self.collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        self.scrollViewDidScroll(collectionView)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension CityViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = (city.forecast.count > 0 ? city.forecast.count : 1)
        self.pageControl.currentPage = 0
        return city.forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherInfoCollectionCell.identifier, for: indexPath) as! WeatherInfoCollectionCell
        cell.model = city.forecast[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        self.pageControl.currentPage = index
    }
}
