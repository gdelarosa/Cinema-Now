//
//  Extensions.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/14/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func makeRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
