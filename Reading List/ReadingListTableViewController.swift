//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Lorenzo on 1/20/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        bookController.loadFromPersistentStore()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            // Pass the bookController variable in the table view controller to the segue's destination view controller. (You will need to cast the destination as the correctly typed view controller)
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.bookController = self.bookController
            }
        }
        
        // If the segue's identifier matches the cell's segue identifier, do the same thing as step 1, and also pass a Book object that was selected in the table view to the destination view controller's book property as well.
        
        if segue.identifier == "ShowBookDetailSegue" {
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.bookController = self.bookController
                bookDetailVC.book = bookFor(indexPath: tableView.indexPathForSelectedRow!)
                bookDetailVC.bookController = self.bookController
            }
        }
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else if indexPath.section == 1 {
            return bookController.unreadBooks[indexPath.row]
        } else {
            fatalError("book for function messed up")
        }
    }
    
    let bookController: BookController = BookController()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else  {
            return bookController.unreadBooks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        if indexPath.section == 0 {
            if bookFor(indexPath: indexPath).hasBeenRead {
                cell.bookLabel.text = bookFor(indexPath: indexPath).title
                cell.readButton.setImage(UIImage(named: "checked"), for: .normal)
            }
        } else {
            if !bookFor(indexPath: indexPath).hasBeenRead {
                cell.bookLabel.text = bookFor(indexPath: indexPath).title
                cell.readButton.setImage(UIImage(named: "unchecked"), for: .normal)
            }
        }
        // needs to return a cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.delete(book: bookFor(indexPath: indexPath))
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        bookController.updateHasBeenRead(book: bookFor(indexPath: self.tableView.indexPath(for: cell)!))
        tableView.reloadData()
    }
}
