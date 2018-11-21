//
//  ChaptersViewController.swift
//  Project 3 Menden Emily
//
//  Created by Emily Prigmore on 11/19/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class ChaptersViewController : UITableViewController {
    
    private struct Storyboard {
        static let ChapterCellIdentifier = "ChapterCell"
        static let ShowChapterContentSegueIdentifier = "ShowChapterContent"
        static let ShowChapterListSegueIdentifier = "ShowChapterList"
    }
    
    // MARK:- Properties

    var book = Book()
    
    // MARK:- Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowChapterContentSegueIdentifier {
            if let scripturesVC = segue.destination as? ScripturesViewController {
                scripturesVC.bookId = book.id
                
                if let indexPath = sender as? IndexPath {
                    scripturesVC.chapter = indexPath.row + 1    // chapters indexed by 1, rows indexed by 0
                }
            }
        }
    }
    
    // MARK:- Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.numChapters ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Storyboard.ChapterCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = "Chapter \(indexPath.row + 1)"
        
        return cell
    }
    
    // MARK:- Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowChapterContentSegueIdentifier, sender: indexPath)
    }
}
