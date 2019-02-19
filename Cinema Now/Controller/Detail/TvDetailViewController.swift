//
//  TvDetailViewController.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/24/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Detail information about TV Shows

import UIKit
import SafariServices

class TvDetailViewController: UIViewController {
    
    var shows: Movie!
    let client = Service()
    var tvID: Int?
    var videoList:[Videos]?
    
    @IBOutlet weak var tvPosterImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvOverview: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var trailersCollection: UICollectionView! 
    @IBOutlet weak var circularProgrss: CircularProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(animateProgress), with: nil, afterDelay: 0.5)
        //backgroundImage.addBlurEffect()
        imageGradient()
        
        // MARK: Movie Data
        guard shows != nil else { return }
        
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
        
        // Display Trailers
        client.tvVideos(tvID: (tvID)!) { (videos: VideoInfo) in
            if let allVideos = videos.results{
                self.videoList = allVideos
                DispatchQueue.main.async {
                    if self.videoList?.count == 0 {
                        //self.videoViewHeight.constant = 0.0
                    }
                    self.trailersCollection.reloadData()
                }
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    var gradient: CAGradientLayer!
    
    func imageGradient() {
        gradient = CAGradientLayer()
        gradient.frame = backgroundImage.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.6, 0.8, 1]
        backgroundImage.layer.mask = gradient
    }
    
    /// Animation for average score
    @objc func animateProgress() {
        
        let cP = self.view.viewWithTag(101) as! CircularProgressView
        cP.setProgressWithAnimation(duration: 0.7, value: 0.2)
        cP.trackColor = UIColor.white
        
        let average = shows.vote_average!
        let one = 1.0...1.9
        let two = 2.0...2.9
        let three = 3.0...3.9
        let four = 4.0...4.9
        let five = 5.0...5.9
        let six = 6.0...6.9
        let seven = 7.0...7.9
        let eight = 8.0...8.9
        let nine = 9.0...9.9
        let ten = 10.0
        
        if one ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.1)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if two ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.2)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if three ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.3)
            cP.progressColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if four ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.4)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if five ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.5)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if six ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.6)
            cP.progressColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if seven ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.7)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if eight ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.8)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if nine ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.9)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if ten ~= average {
            cP.setProgressWithAnimation(duration: 0.7, value: 1.0)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            cP.setProgressWithAnimation(duration: 0.7, value: 0.0)
            cP.progressColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
    
    // MARK: Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Opens trailer in Youtube when tapped
    @objc func tapVideo(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: self.trailersCollection)
        let indexPath = self.trailersCollection.indexPathForItem(at: location)
        
        if let index = indexPath {
            let video_one = self.videoList![index[1]]
            if let video_key = video_one.key{
                let videoURL = client.youtubeURL(path: video_key)
                if let videourl = videoURL{
                    print(videourl)
                    
                    let safariVC = SFSafariViewController(url: videourl)
                    present(safariVC, animated: true, completion: nil)
                }
            }
        }
    }

}

extension TvDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if collectionView == self.trailersCollection{
            if let number = self.videoList?.count {
                return number
            }
            else{
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let trailerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trailerCell", for: indexPath) as! TrailersCell
        
        if collectionView == self.trailersCollection {
            let video_one = self.videoList![indexPath.row]
            if let video_key = video_one.key {
                let videoThumbURL = client.youtubeThumb(path: video_key)
                
                let url = videoThumbURL
                
                if let data = try? Data(contentsOf: url!)  {
                    trailerCell.imageView.image = UIImage(data: data)
                }  else {
                    print("There is no video data available")
                }
            } else {
                print("Unable to get youtube video")
            }
            trailerCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapVideo(_:))))
        }
        
        return trailerCell
    }
}

