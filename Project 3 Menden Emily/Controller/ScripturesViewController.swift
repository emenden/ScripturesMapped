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
    
    private struct Storyboard {
        static let ShowMapSegueIdentifier = "ShowMap"
        static let ShowChapterAnnotsMapIdentifier = "ShowChapterAnnotsMap"
    }
    
    // MARK:- Properties
    
    var bookId = 101
    var chapter = 2
    var geoplaces = [GeoPlace]()
    
    // MARK:- Private Properties
    
    private weak var mapViewController: MapViewController?
    
    // MARK:- Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    // MARK:- Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowMapSegueIdentifier {
            if let geoplace = sender as? GeoPlace {
                configureMapForSingleAnnotation(geoplace)
            }
        }
        else if segue.identifier == Storyboard.ShowChapterAnnotsMapIdentifier {
            configureMapForChapterAnnotations()
        }
    }
    
    // MARK:- View controller lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("in viewDidLayoutSubviews")
        configureDetailViewController()
    }
    
    override func viewDidLoad() {
        print("in viewDidLoad")
        super.viewDidLoad()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookId, chapter: chapter)
        print("geoplaces in scriptures viewDidLoad")
        print(geoplaces)
        self.geoplaces = geoplaces
        
        MapConfig.sharedMapConfig.geoplaces = geoplaces
        mapViewController?.annotations = []
        
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    // MARK:- Navigation delegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let path = navigationAction.request.url?.absoluteString {
            let baseUrl = ScriptureRenderer.Constant.baseUrl
            
            if path.hasPrefix(baseUrl) {
                if mapViewController == nil {
                    print("There is no map view controller")
                    
                    if let geoplace = getGeoplaceFromUrl(path) {
                        performSegue(withIdentifier: Storyboard.ShowMapSegueIdentifier, sender: geoplace)
                    }
                } else {
                    print("There is a map view controller")
                    if let geoplace = getGeoplaceFromUrl(path) {
                        MapConfig.sharedMapConfig.title = geoplace.placename
                        mapViewController?.zoomOnLocation(geoplace)
                    }
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
                print("in configureDetailViewController")
                configureMapForChapterAnnotations()
                
                if mapViewController?.mapView != nil {
                    mapViewController?.configureMap()
                    MapConfig.sharedMapConfig.title = "Chapter \(chapter)"
                }
            }
        } else {
            mapViewController = nil
        }
    }
    
    private func configureMapForChapterAnnotations() {
        MapConfig.sharedMapConfig.geoplaces.removeAll()
        MapConfig.sharedMapConfig.geoplaces = geoplaces
        
        MapConfig.sharedMapConfig.selectedGeoplace = nil
        MapConfig.sharedMapConfig.focusOnOne = false
        MapConfig.sharedMapConfig.title = "Chapter \(chapter)"
    }
    
    private func configureMapForSingleAnnotation(_ geoplace: GeoPlace) {
        MapConfig.sharedMapConfig.geoplaces.removeAll()
        MapConfig.sharedMapConfig.geoplaces.append(geoplace)
        
        MapConfig.sharedMapConfig.selectedGeoplace = geoplace
        MapConfig.sharedMapConfig.focusOnOne = true
        MapConfig.sharedMapConfig.title = geoplace.placename
    }
    
    private func getGeoplaceFromUrl(_ path: String) -> GeoPlace? {
        let baseUrl = ScriptureRenderer.Constant.baseUrl
        
        if let geoplaceId = Int(path.substring(fromOffset: baseUrl.count)) {
            if let geoplace = GeoDatabase.sharedGeoDatabase.geoPlaceForId(geoplaceId) {
                return geoplace
            }
        }
    
        return nil
    }
}
