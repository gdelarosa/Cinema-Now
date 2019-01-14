//
//  CategoryRow.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Popular, Trending

import UIKit

class NowPlayingRow : UITableViewCell {
    
    let client = Service()
    var movies: [Movie] = []
    var cancelRequest: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
       loadNowPlayingData()
    }

    
    private func loadNowPlayingData(onPage page: Int = 1) {
        guard !cancelRequest else { return }
        let _ = client.taskForGETMethod(Methods.NOW_PLAYING, parameters: [ParameterKeys.PAGE: page as AnyObject]) { (data, error) in
            if error == nil, let jsonData = data {
                let result = MovieResults.decode(jsonData: jsonData)
                if let movieResults = result?.results {
                    self.movies += movieResults
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                if let totalPages = result?.total_pages, page < totalPages {
                    guard !self.cancelRequest else {
                        print("Cancel Request Failed")
                        return
                        
                    }
                    self.loadNowPlayingData(onPage: page + 1)
                }
            } else if let error = error, let retry = error.userInfo["Retry-After"] as? Int {
                print("Retry after: \(retry) seconds")
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: Double(retry), repeats: false, block: { (_) in
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

extension NowPlayingRow : UICollectionViewDataSource {
    
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
