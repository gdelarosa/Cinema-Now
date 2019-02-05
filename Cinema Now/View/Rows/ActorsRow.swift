//
//  MovieTableViewCell.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.


import UIKit

class ActorsRow: UITableViewCell {
    
    let client = Service()
    var movies: [Movie] = []
    var cancelRequest: Bool = false
    var person: [Cast]?

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        loadTrendingData()
    }
    
    private func loadTrendingData(onPage page: Int = 1) {
        guard !cancelRequest else { return }
        let _ = client.taskForGETMethod(Methods.POPULAR_ACTORS, parameters: [ParameterKeys.TOTAL_RESULTS: page as AnyObject]) { (data, error) in
            if error == nil, let jsonData = data {
                
                let result = MovieResults.decode(jsonData: jsonData)
                
                if let movieResults = result?.results {
                    self.movies += movieResults
                    
                    DispatchQueue.main.async {
                        self.movieCollectionView.reloadData()
                    }
                }
                
                if let totalPages = result?.total_pages, totalPages < 10 {
                    guard !self.cancelRequest else {
                        print("Total Pages Actors: \(totalPages)")
                        print("Cancel Request Failed")
                        return
                        
                    }
                    self.loadTrendingData(onPage: page + 1)
                }
            } else if let error = error, let retry = error.userInfo["Retry-After"] as? Int {
                print("Retry after: \(retry) seconds")
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: Double(20), repeats: false, block: { (_) in
                        print("Retrying...")
                        guard !self.cancelRequest else { return }
                        self.loadTrendingData(onPage: 1)
                        return
                    })
                   
                }
            } else {
                print("Error code: \(String(describing: error?.code))")
                print("There was an error: \(String(describing: error?.userInfo))")
            }
        }
    }
}

extension ActorsRow: UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! ActorCell
        
        let movie = movies[indexPath.row]
        
        // set poster image
        if let posterPath = movie.profile_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.DETAIL_POSTER, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
                if let image = UIImage(data: imageData!) {
                    
                    DispatchQueue.main.async {
                        cell.activityIndicator.alpha = 0.0
                        cell.activityIndicator.stopAnimating()
                        cell.imageView.image = image
                    }
                }
            })
        } else {
            cell.activityIndicator.alpha = 0.0
            cell.activityIndicator.stopAnimating()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Begin asynchronously fetching data for the requested index paths.
        for item in indexPaths {
            print ( "Prefetching Rows: \( item.row)" )
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if let mainViewController = parentViewController as? HomeViewController {
            guard movies.count > indexPath.row else { return }
            let movie = movies[indexPath.row]
           
            
            guard let detailVC = mainViewController.storyboard?.instantiateViewController(withIdentifier: "actorDetail") as? ActorDetailViewController else { return }
            detailVC.movie = movie
            detailVC.personID = movie.id
            
            mainViewController.show(detailVC, sender: self)
        }
    }
}



