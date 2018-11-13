//
//  AppDelegate.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/11/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    private struct Storyboard {
        static let MainStoryboardName = "Main"
        static let MapVCIdentifier = "DetailVC"
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let splitViewController = window!.rootViewController as? UISplitViewController {
            splitViewController.delegate = self
        }
        
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary                            secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        return true
    }

    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        
        if let navVC = primaryViewController as? UINavigationController {
            for controller in navVC.viewControllers {
                if controller.restorationIdentifier == Storyboard.MapVCIdentifier {
                    return controller
                }
            }
        }
        
        let storyboard = UIStoryboard(name: Storyboard.MainStoryboardName, bundle: nil)
       
        return storyboard.instantiateViewController(withIdentifier: Storyboard.MapVCIdentifier)
    }
}

