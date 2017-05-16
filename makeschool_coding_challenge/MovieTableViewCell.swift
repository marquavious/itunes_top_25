//
//  MovieTableViewCell.swift
//  makeschool_coding_challenge
//
//  Created by Marquavious on 5/3/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieReleaseLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
