//
//  MovieTableViewController.swift
//
//
//  Created by Marquavious on 5/4/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class MovieTableViewController: UITableViewController {
    
    var arrayOfMovies = [Movie]() // Sets array for all movies
    let movieTableviewNib = UINib(nibName: "MovieTableViewCell", bundle: nil) // Loads NIB for tableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchTopTwentyfiveMovies() // Runs our function that gathers movies
        tableView.register(movieTableviewNib, forCellReuseIdentifier: "MovieTableViewCell") // Registers NIB for tableView
    }
    
    // Fetches all movie info from backend
    func fetchTopTwentyfiveMovies(){
        // Sends request from Alamofire
        Alamofire.request("https://itunes.apple.com/us/rss/topmovies/limit=25/json").responseJSON { response in
            if let movieInJsonFormat = response.result.value { // If there is a response...
                let json = JSON(movieInJsonFormat) // Use SwiftyJSON to parse it
                for movieFromJSON in json["feed"]["entry"].arrayValue { // For movie node in jason
                    let movie = Movie() // Creates movie object
                    movie.price = movieFromJSON["im:price"]["label"].string! // Sets price
                    movie.releaseDate = movieFromJSON["im:releaseDate"]["attributes"]["label"].string! // Sets price
                    movie.title = movieFromJSON["im:name"]["label"].string! // Sets price
                    movie.description = movieFromJSON["summary"]["label"].string! // Sets price
                    movie.photoURL = movieFromJSON["im:image"][2]["label"].string! // Sets price
                    movie.itunesLink = movieFromJSON["id"]["label"].string! // Sets price
                    self.arrayOfMovies.append(movie) // Appends movie to array for display
                    self.tableView.reloadData() // Reloads tableview
                }
            }
        }
    }
    
    // Height for tableView cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    // Perform segue when user taps cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMovie", sender: self)
    }
    
    // Populate tableView with a correct number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMovies.count
    }
    
    // Set up cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movie = arrayOfMovies[indexPath.row] // Grabs movie from
        cell.moviePriceLabel.text = movie.price // Sets price label
        cell.movieTitleLabel.text = movie.title // Sets movie title label
        cell.movieReleaseLabel.text = movie.releaseDate // Sets release label
        return cell
    }
    
    // Prepares segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovie"{ // Checks segue identifier
            // Creats a MovieDetailViewController instance so we can use the "movie" object
            let destination = segue.destination as! MovieDetailViewController
            var indexPath = tableView.indexPathForSelectedRow // Grabs index path of selected cell
            let movie = arrayOfMovies[(indexPath?.row)!] // Grabs movie in array from the index path choosen
            destination.movie = movie // Sets the movie object in the MovieDetailViewController
        }
    }
}
