//
//  MovieCell.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  Will be actors 

import UIKit

class MovieCell: UICollectionViewCell {
    
   @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        imageView.makeRounded()
    }
}

extension UIImageView {
    
    func makeRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
