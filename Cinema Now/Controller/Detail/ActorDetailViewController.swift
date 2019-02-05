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
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var actorCredits: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    var movie: Movie!
    var person: Person!
    
    let client = Service()
    var shows: [Movie] = []
    var cast = [CastData]()
    
    var personID: Int?
    var cancelRequest: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
        // MARK: Movie Data
        guard movie != nil else { return }
        guard personID != nil else { return }
        
        //Name
        nameLabel.text = movie.name
        
        //Bio
        client.personDetails(person_id: self.personID!) { (personRes: Person) in
            
            if let bio = personRes.biography {
                DispatchQueue.main.async {
                    self.bio.text = bio
                }
            }
        }
        
        //Photo
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
        
        //Credits
        client.personMovieCredits(personID: self.personID!) { (personCredit:PeopleCredits) in
            if let cast = personCredit.cast{
                self.cast = cast
            }
            DispatchQueue.main.async {
                if self.cast.count == 0 {
                    print("There are no items for cast")
                }
                self.loading.alpha = 0.0
                self.loading.stopAnimating()
                self.actorCredits.reloadData()
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

extension ActorDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.actorCredits {
            return self.cast.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "creditsCell", for: indexPath) as! ActorCreditsCell
        
        if collectionView == self.actorCredits {
            let cast_one = self.cast[indexPath.row]
            
            // set poster image
            if let posterPath = cast_one.poster_path {
                let _ = client.taskForGETImage(ImageKeys.PosterSizes.DETAIL_POSTER, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
                    if let image = UIImage(data: imageData!) {
                        
                        DispatchQueue.main.async {
                            movieCell.activityIndicator.alpha = 0.0
                            movieCell.activityIndicator.stopAnimating()
                            movieCell.movieImage.image = image
                        }
                    }
                })
            } else {
                movieCell.activityIndicator.alpha = 0.0
                movieCell.activityIndicator.stopAnimating()
            }
            
            //movieCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapMovie(_:))))
        }
        
        return movieCell
    }
    
    // Should show movie detail.
    @objc func tapMovie(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: self.actorCredits)
        let indexPath = self.actorCredits.indexPathForItem(at: location)

        if let index = indexPath {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let movieDetailsController = storyBoard.instantiateViewController(withIdentifier: "movieDetail") as! DetailViewController

            movieDetailsController.movieID = self.cast[index[1]].id
            self.showDetailViewController(movieDetailsController, sender: self)
        }
    }
    
}
