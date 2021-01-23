//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Lorenzo on 1/20/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var backgroundCardView: UIView!
    func updateUI() {
//        backgroundCardView.backgroundColor = UIColor.white
//        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
//        backgroundCardView.layer.cornerRadius = 3.0
//        backgroundCardView.layer.masksToBounds = false
//        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
//        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        backgroundCardView.layer.shadowOpacity = 0.8
    }
    
//    func updateViews() {
//        print("update views called from table view cell")
//        guard let newBook = book else { return }
//        bookLabel.text = newBook.title
//        newBook.hasBeenRead ? readButton.setImage(UIImage(named: "checked"), for: .normal) : readButton.setImage(UIImage(named: "unchecked"), for: .normal)
//    }
    
    weak var delegate: BookTableViewCellDelegate?

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
