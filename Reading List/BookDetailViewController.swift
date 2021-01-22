//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lorenzo on 1/22/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var detailTextArea: UITextView!
    
    @IBAction func save(_ sender: Any) {
        if let unwrappedBook = book {
            bookController?.updateBook(book: unwrappedBook, newBookTitle: detailTextField.text ?? nil, newReasonToRead: detailTextArea.text ?? nil)
        } else {
            if detailTextField.text != "" {
                bookController?.create(title: detailTextField.text!, reasonToRead: detailTextArea.text ?? "")
            } else {
                let alert = UIAlertController(title: "Error", message: "Title is required", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                      switch action.style{
                      case .default:
                            print("default")

                      case .cancel:
                            print("cancel")

                      case .destructive:
                            print("destructive")


                }}))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
        }
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    func updateViews() {
        if book != nil {
            detailTextField.text = book?.title
            detailTextArea.text = book?.reasonToRead
            self.title = book?.title
        } else {
            self.title = "Add a new book"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
}
