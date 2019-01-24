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
    var gradient: CAGradientLayer!
    
    @IBOutlet weak var onAirCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onAirCollectionView.reloadData()
        loadLatestTvData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    private func loadLatestTvData(onPage page: Int = 1) {
        guard !cancelRequest else { return }
        let _ = client.taskForGETMethod(Methods.TRENDING_TV, parameters: [ParameterKeys.TOTAL_RESULTS: page as AnyObject]) { (data, error) in
            if error == nil, let jsonData = data {
                
                let result = MovieResults.decode(jsonData: jsonData)
                if let movieResults = result?.results {
                    self.shows += movieResults
                    DispatchQueue.main.async {
                        self.onAirCollectionView.reloadData()
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
      
        let onAirCell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularTv", for: indexPath) as! OnAirCell
        
        let tv = shows[indexPath.row]
        
        onAirCell.nameLabel.text = tv.name
        onAirCell.firstAirDate.text = ("Original Air Date: " + (tv.first_air_date?.convertDateString())!)
        
        if let posterPath = tv.poster_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.ORIGINAL_POSTER, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
                if let image = UIImage(data: imageData!) {
                    
                    DispatchQueue.main.async {
                        onAirCell.activityIndicator.alpha = 0.0
                        onAirCell.activityIndicator.stopAnimating()
                        onAirCell.onAirImage.image = image
                    }
                }
            })
        } else {
            onAirCell.activityIndicator.alpha = 0.0
            onAirCell.activityIndicator.stopAnimating()
        }
        return onAirCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard shows.count > indexPath.row else { return }
        let tv = shows[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "tvDetail") as? TvDetailViewController else { return }
        detailVC.shows = tv
        self.showDetailViewController(detailVC, sender: self)
    }
}
