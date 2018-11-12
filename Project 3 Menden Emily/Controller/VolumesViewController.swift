//
//  VolumesViewController.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/12/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class VolumesViewController: UITableViewController {
    
    private struct Storyboard {
        static let ShowBooksSegueIdentifier = "ShowBooks"
        static let VolumeCellIdentifier = "VolumeCell"
    }
    
    var volumes = GeoDatabase.sharedGeoDatabase.volumes()
    
    // MARK:- Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowBooksSegueIdentifier {
            if let booksVC = segue.destination as? BooksViewController {
                if let indexPath = sender as? IndexPath {
                    booksVC.volume = volumes[indexPath.row]
                    booksVC.volumeId = indexPath.row + 1
                }
            }
        }
    }
    
    // MARK:- Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volumes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.VolumeCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = volumes[indexPath.row]
        
        return cell
    }
    
    // MARK:- Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowBooksSegueIdentifier, sender: indexPath)
    }
}
