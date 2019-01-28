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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
