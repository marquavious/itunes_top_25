//
//  MovieDetailViewController.swift
//  makeschool_coding_challenge
//
//  Created by Marquavious on 5/6/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // Movie object
    var movie:Movie!
    
    // IBOutles
    @IBOutlet weak var buyMovieButton: UIButton!
    @IBOutlet weak var movieCoverImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieInfo() // Runs function that sets up movie for display
    }
    
    // Sets up movie info for display
    func setupMovieInfo(){
        movieTitleLabel.text = movie.title
        movieDescriptionTextView.text = movie.description
        movieReleaseLabel.text = movie.releaseDate!
        movieCoverImage.loadImageUsingCacheWithUrlString(movie.photoURL!) // Runs UIImage extention for downloading images
        buyMovieButton.setTitle("💵 Buy for \(String(describing: movie.price!))", for: .normal)
    }
    
    @IBAction func buyMovieButtonPressed(_ sender: Any) {
        let url = URL(string: movie.itunesLink!) // Creats URL for iTunes link up
        UIApplication.shared.open(url!) // Opens movie in iTunes
    }
}
