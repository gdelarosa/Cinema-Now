//
//  ActorDetailViewController.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/22/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import UIKit

class ActorDetailViewController: UIViewController {
    
    @IBOutlet weak var actorPosterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var movie: Movie!
    let client = Service()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Movie Data
        guard movie != nil else { return }
        
        // Actor's Photo
        if let posterPath = movie.profile_path {
            let _ = client.taskForGETImage(ImageKeys.PosterSizes.DETAIL_POSTER, filePath: posterPath) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.actorPosterImage.image = image
                    }
                }
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
