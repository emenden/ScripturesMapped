//
//  MapConfig.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/15/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import Foundation

class MapConfig {
    
    static let sharedMapConfig = MapConfig()
    
    // MARK:- Properties
    var geoplaces = [GeoPlace]()
    var title: String = ""
    var focusOnOne = false
    var selectedGeoplace: GeoPlace?
}
