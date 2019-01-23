//
//  UIImageView.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Set placeholder image and download image from Url in background. First
    /// try from Cache then load using Cache policy URLRequest.CachePolicy.returnCacheDataElseLoad
    ///
    /// - Parameters:
    ///   - url: image url
    ///   - placeholder: placeholder image will be shown until image downloaded
    func downloaded(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder ?? image
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    
    /// Set placeholder image and download image from Url link in background. First
    /// try from Cache then load using Cache policy URLRequest.CachePolicy.returnCacheDataElseLoad
    ///
    /// - Parameters:
    ///   - link: image url link in String
    ///   - placeholder: placeholder image will be shown until image downloaded
    func downloaded(from link: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
