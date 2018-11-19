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
    
    // MARK:- Properties
    
    var annotations = [MKPointAnnotation]()
    var mapTitle: String = ""
    
    // MARK:- Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK:- View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in map viewDidLoad")
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        }
        
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constant.AnnotationReuseIdentifier)
        /*
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2DMake(40.2506, -111.65247)
        annotation.title = "Tanner Building"
        annotation.subtitle = "BYU Campus"
        
        mapView.addAnnotation(annotation)*/
        //showAnnotations()
        title = mapTitle
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("in map viewDidAppear")
        
        /*
        // one way to set the camera
        let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(40.2506, -111.65247), fromEyeCoordinate: CLLocationCoordinate2DMake(40.2306, -111.65247), eyeAltitude: 500)
        // ^^ need to go further to the south on eye Coordinate for 3d ?
        
        mapView.setCamera(camera, animated: true)
        
        // another way to set the camera
        let center = CLLocationCoordinate2DMake(40.2506, -111.65247)
        let span  = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let viewRegion = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(viewRegion, animated: true)
        */
        configureMap()
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
    
    func configureMap() {
        print("configuring map")
        
        mapTitle = MapConfig.sharedMapConfig.title
        
        if annotations.count == 0 {
            createAnnotations(MapConfig.sharedMapConfig.geoplaces)
        }

        showAnnotations()
        
        if MapConfig.sharedMapConfig.focusOnOne == true {
            if let geoplace = MapConfig.sharedMapConfig.selectedGeoplace {
                zoomOnLocation(geoplace)
            }
        }
    }
    
    func createAnnotations(_ geoplaces: [GeoPlace]) {
        print("creating annotations")
        
        for place in geoplaces {
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2DMake(place.latitude, place.longitude)
            annotation.title = place.placename
            
            annotations.append(annotation)
        }
    }
    
    func showAnnotations() {
        print("showing annotations")
        
        self.mapView.showAnnotations(annotations, animated: true)
    }
    
    func zoomOnLocation(_ geoplace: GeoPlace) {
        let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(geoplace.latitude, geoplace.longitude), fromEyeCoordinate: CLLocationCoordinate2DMake(geoplace.viewLatitude, geoplace.viewLongitude), eyeAltitude: geoplace.viewAltitude)
        
        mapView.setCamera(camera, animated: true)
    }
    
}
