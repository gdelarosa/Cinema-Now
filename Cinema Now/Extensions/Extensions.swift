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
    // Make image rounded
    func makeRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    // Adds Blur
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.frame = self.bounds
        self.addSubview(blurEffectView)
    }
}
// Converts String to Date
extension String {
    
    func convertDateString() -> String? {
        return convert(dateString: self, fromDateFormat: "yyyy-MM-dd", toDateFormat: "MMM d, yyyy")
    }

    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {
        
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat
        
        if let fromDateObject = fromDateFormatter.date(from: dateString) {
            
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat
            
            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }
        return nil
    }
}
// Assists with pushing data to detail view controller
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

