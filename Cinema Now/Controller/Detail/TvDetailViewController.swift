//
//  TvDetailViewController.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/24/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Detail information about TV Shows

import UIKit

class TvDetailViewController: UIViewController {
    
    var shows: Movie!
    let client = Service()
    
    @IBOutlet weak var tvPosterImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvOverview: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var circularProgrss: CircularProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvName.text = shows.name
        tvOverview.text = shows.overview
        
        // Movie Average
        if let average = shows.vote_average {
            let rating = String(format:"%.1f", average)
            ratingLabel.text = "\(rating)"
        }
        
        // Tv Poster
        if let posterPath = shows.poster_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.DETAIL_POSTER, filePath: posterPath) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.tvPosterImage.image = image
                    }
                }
            }
        }
        
        // TV Backdrop
        if let bannerPath = shows.backdrop_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.BACK_DROP, filePath: bannerPath) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.backgroundImage.image = image
                    }
                }
            }
        }
    }

}
