//
//  TvViewController.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/23/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Will display TV shows currently on air

import UIKit

class TvViewController: UIViewController {
    
    var shows: [Movie] = []
    let client = Service()
    var cancelRequest: Bool = false
    
    @IBOutlet weak var popularTvCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLatestTvData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    private func loadLatestTvData(onPage page: Int = 1) {
        guard !cancelRequest else { return }
        let _ = client.taskForGETMethod(Methods.ON_THE_AIR, parameters: [ParameterKeys.TOTAL_RESULTS: page as AnyObject]) { (data, error) in
            if error == nil, let jsonData = data {
                
                let result = MovieResults.decode(jsonData: jsonData)
                if let movieResults = result?.results {
                    self.shows += movieResults
                    DispatchQueue.main.async {
                        self.popularTvCollectionView.reloadData()
                    }
                }
                if let totalPages = result?.total_pages, totalPages < 10 {
                    guard !self.cancelRequest else {
                        print("Cancel Request Failed")
                        return
                        
                    }
                    self.loadLatestTvData(onPage: page + 1)
                }
            } else if let error = error, let retry = error.userInfo["Retry-After"] as? Int {
                print("Retry after: \(retry) seconds")
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: Double(retry), repeats: false, block: { (_) in
                        print("Retrying...")
                        guard !self.cancelRequest else { return }
                        self.loadLatestTvData(onPage: page)
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

extension TvViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let popularTvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTv", for: indexPath) as! PopularTVCell
        
        let tv = shows[indexPath.row]
        if let posterPath = tv.poster_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.DETAIL_POSTER, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
                if let image = UIImage(data: imageData!) {
                    
                    DispatchQueue.main.async {
                        popularTvCell.activityIndicator.alpha = 0.0
                        popularTvCell.activityIndicator.stopAnimating()
                        popularTvCell.popularTvImage.image = image
                    }
                }
            })
        } else {
            popularTvCell.activityIndicator.alpha = 0.0
            popularTvCell.activityIndicator.stopAnimating()
        }
        return popularTvCell
    }
    
    
}
