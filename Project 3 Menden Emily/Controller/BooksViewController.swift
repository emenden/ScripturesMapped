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
        static let ShowScripturesSegueIdentifier = "ShowChapterContent"
    }
    
    var books = [Book]()
    var volume = ""
    var volumeId = 1
    
    //MARK:- View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
    }
    
    // MARK:- Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scripturesVC = segue.destination as? ScripturesViewController {
            if let indexPath = sender as? IndexPath {   // could send a Book instead
                scripturesVC.bookId = books[indexPath.row].id
                scripturesVC.chapter = 7
            }
        }
        // when preparing for segue to map, could use Configuration object or could set all values needed here
    }
    
    // MARK:- Table view Data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.BookCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = books[indexPath.row].fullName
        
        return cell
    }
    
    // MARK:- Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: Storyboard.ShowScripturesSegueIdentifier, sender: self)
        performSegue(withIdentifier: Storyboard.ShowScripturesSegueIdentifier, sender: indexPath)
    }
    
    // MARK:- Helpers
    
    private func updateModel() {
        title = volume
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeId)
    }
}
