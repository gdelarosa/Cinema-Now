//
//  AboutViewController.swift
//  Cinema Now
//
//  Created by Gina De La Rosa on 1/23/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//  About View Controller

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()       
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    @IBAction func githubLink(_ sender: Any) {
        if let url = URL(string: "https://github.com/gdelarosa/Cinema-Now") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func mailLink(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Cinema Now Inquiry"
            let toRecipents = ["ginacdlr@gmail.com"]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setToRecipients(toRecipents)
            self.present(mc, animated: true, completion: nil)
        } else {
            print("Unable to open mail app")
            let myalert = UIAlertController(title: "Oops!", message: "There was an issue opening your mail app. Please check your settings on your device.", preferredStyle: UIAlertController.Style.alert)
            myalert.addAction(UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel")
            })
            
            self.present(myalert, animated: true)
        }
    }
    
    @IBAction func movieApiLink(_ sender: Any) {
        if let url = URL(string: "https://www.themoviedb.org/documentation/api") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}
