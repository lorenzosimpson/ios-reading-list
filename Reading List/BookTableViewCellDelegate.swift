//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Lorenzo on 1/21/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
