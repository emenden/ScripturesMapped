//
//  MapViewController.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/12/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    
    // MARK:- Constants
    
    private struct Constant {
        static let AnnotationReuseIdentifier = "MapPin"
    }
    
    // MARK:- Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK:- View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
        
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constant.AnnotationReuseIdentifier)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2DMake(40.2506, -111.65247)
        annotation.title = "Tanner Building"
        annotation.subtitle = "BYU Campus"
        
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // one way to set the camera
        let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(40.2506, -111.65247), fromEyeCoordinate: CLLocationCoordinate2DMake(40.2306, -111.65247), eyeAltitude: 500)
        // ^^ need to go further to the south on eye Coordinate for 3d ?
        
        mapView.setCamera(camera, animated: true)
        
        // another way to set the camera
        let center = CLLocationCoordinate2DMake(40.2506, -111.65247)
        let span  = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let viewRegion = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(viewRegion, animated: true)
    }
    
    // MARK:- Map view delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: Constant.AnnotationReuseIdentifier, for: annotation)
        
        if let pinView = view as? MKPinAnnotationView {
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.pinTintColor = UIColor.purple
        }
        
        return view
    }
    
    // MARK:- Helpers
    
    func configureMap(_ geoplaces: [GeoPlace]) {
        for place in geoplaces {
            print("\(place.placename) at \(place.latitude), \(place.longitude)")
            
            //mapView.addAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
        }
    }
    
}
