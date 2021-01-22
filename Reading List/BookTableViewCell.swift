//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lorenzo on 1/20/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    
    func updateViews() {
        guard let newBook = book else { return }
        bookLabel.text = newBook.title
        newBook.hasBeenRead ? readButton.setImage(UIImage(named: "checked"), for: .normal) : readButton.setImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    weak var delegate: BookTableViewCellDelegate?

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    @IBAction func toggleRead(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
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
