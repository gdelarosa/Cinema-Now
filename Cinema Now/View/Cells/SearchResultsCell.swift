//
//  SearchResultsCell.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/27/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var averageRating: UILabel!
    
    let client = Service()
    
    var movie: Movie? {
        didSet {
        updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    // MARK: - Setup
    func updateViews() {
        guard let movie = movie else { return }
        DispatchQueue.main.async {
            self.movieTitle.text = movie.title
            self.averageRating.text = movie.release_date?.convertDateString()
        }
        // set poster image
        if let posterPath = movie.poster_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.DETAIL_POSTER, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
                if let image = UIImage(data: imageData!) {
                    
                    DispatchQueue.main.async {
                        self.movieImage.image = image
                    }
                }
            })
        } else {
            print("Unable to load search results.")
        }
    }
}
