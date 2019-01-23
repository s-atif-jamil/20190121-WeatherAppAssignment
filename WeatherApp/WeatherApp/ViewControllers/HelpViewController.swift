//
//  HelpViewController.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: BaseViewController {

    @IBOutlet var webView: WKWebView!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.webView.navigationDelegate = self
        if let url = Bundle.main.url(forResource: "Help", withExtension: "html") {
            self.webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    
}


// MARK: - WKNavigationDelegate

extension HelpViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
