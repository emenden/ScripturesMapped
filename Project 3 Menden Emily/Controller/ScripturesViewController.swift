//
//  ScripturesViewController.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/12/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController {
    
    var bookId = 101
    var chapter = 2
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (html, _) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookId, chapter: chapter)
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
