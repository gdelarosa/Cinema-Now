//
//  CategoryRow.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Popular, Trending

import UIKit

protocol NowPlayingDelegate {
    func goToNowPlayingDetail()
}

class NowPlayingRow : UITableViewCell {
    
    let client = Service()
    var movies: [Movie] = []
    var cancelRequest: Bool = false
    
    var delegate: NowPlayingDelegate?

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
       loadNowPlayingData()
    }
    
    private func loadNowPlayingData(onPage page: Int = 1) {
        guard !cancelRequest else { return }
        let _ = client.taskForGETMethod(Methods.NOW_PLAYING, parameters: [ParameterKeys.TOTAL_RESULTS: page as AnyObject]) { (data, error) in
            if error == nil, let jsonData = data {
                let result = MovieResults.decode(jsonData: jsonData)
                if let movieResults = result?.results {
                 
                    self.movies += movieResults
                    
                    // Reloading data must be used on the main thread
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                if let totalPages = result?.total_pages, totalPages < 10 {
                    guard !self.cancelRequest else {
                        print("Cancel Request Failed")
                        return

                    }
                    self.loadNowPlayingData(onPage: page + 1)
                }
                
                
            } else if let error = error, let retry = error.userInfo["Retry-After"] as? Int {
                print("Retry after: \(retry) seconds")
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: Double(20), repeats: false, block: { (_) in
                        print("Retrying...")
                        guard !self.cancelRequest else { return }
                        self.loadNowPlayingData(onPage: page)
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

extension NowPlayingRow : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        print("Tapped Cell for Now Playing")
        self.delegate?.goToNowPlayingDetail()
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! NowPlayingCell
        
        let movie = movies[indexPath.row]
        
        // set poster image
        if let posterPath = movie.poster_path {
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

}

extension NowPlayingRow : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
