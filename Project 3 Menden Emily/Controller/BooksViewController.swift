//
//  BooksViewController.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/12/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController {

    private struct Storyboard {
        static let BookCellIdentifier = "BookCell"
    }
    
    var books = GeoDatabase.sharedGeoDatabase.booksForParentId(1)
    var volume = ""
    var volumeId = 1
    
    //MARK:- View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = volume
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeId)
    }
    
    // MARK:- Data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.BookCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = books[indexPath.row].fullName
        
        return cell
    }
}