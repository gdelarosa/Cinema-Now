//
//  CreditsCell.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 2/5/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import UIKit

class CreditsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        imageView.makeRounded()
    }
}
