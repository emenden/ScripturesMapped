//
//  ScripturesViewController.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/12/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController, WKNavigationDelegate {
    
    // MARK:- Properties
    
    var bookId = 101
    var chapter = 2
    
    // MARK:- Private Properties
    
    private weak var mapViewController: MapViewController?
    
    // MARK:- Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK:- View controller lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureDetailViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetailViewController()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookId, chapter: chapter)
        
        if let mapVC = mapViewController {
            mapVC.configureMap(geoplaces)
        }
        
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    // MARK:- Navigation delegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let path = navigationAction.request.url?.absoluteString {
            let baseUrl = ScriptureRenderer.Constant.baseUrl
            
            if path.hasPrefix(baseUrl) {
                if let geoplaceId = Int(path.substring(fromOffset: baseUrl.count)) {
                    // NEEDSWORK: focus on geoplaceID
                    print("Focusing on geoplace \(geoplaceId)")
                }
                
                if mapViewController == nil {
                    print("There is no map view controller")
                } else {
                    print("There is a map view controller")
                }
    
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    // MARK:- Helpers
    
    private func configureDetailViewController() {
        if let splitVC = splitViewController {
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapViewController
            }
        } else {
            mapViewController = nil
        }
    }
}
