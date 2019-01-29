//
//  SearchViewController.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/27/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchController: UISearchBar!
    
    // MARK: - Properties
    var movies: [Movie] = []
    let client = Service()
    var cancelRequest: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    /// Searches movies after selecting Search on bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        
        Service.fetchMovie(with: searchTerm) { (movies) in
            guard let fetchedMovies = movies else { return }
            self.movies = fetchedMovies
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
                searchBar.text = nil
            }
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as!SearchResultsCell
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard movies.count > indexPath.row else { return }
        let movie = movies[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? DetailViewController else { return }
        detailVC.movie = movie
        self.showDetailViewController(detailVC, sender: self)
    }

}

