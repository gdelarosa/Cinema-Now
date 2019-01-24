//
//  PopularTVCell.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/23/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import UIKit

class OnAirCell: UICollectionViewCell {
    
    @IBOutlet weak var onAirImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstAirDate: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var gradient: CAGradientLayer!
    
    override func awakeFromNib() {
        imageGradient()
    }
    
    func imageGradient() {
        gradient = CAGradientLayer()
        gradient.frame = onAirImage.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.6, 0.8, 1]
        onAirImage.layer.mask = gradient
    }
}
