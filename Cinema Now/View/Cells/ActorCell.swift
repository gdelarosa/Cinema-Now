//
//  ActorCell.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Actors 

import UIKit

class ActorCell: UICollectionViewCell {
    
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        imageView.makeRounded()
    }
}

