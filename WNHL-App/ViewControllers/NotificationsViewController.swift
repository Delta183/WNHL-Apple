//
//  NotificationsViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        // The info label is set here as opposed to setting a static text view on the Notifications View
        infoLabel.text = "Select a Team to receive notifications for Upcoming Games.\nTo stop receiving notifications, deselect the Team."
        // Removing the limit is done through setting number of lines to 0 as labels initially can only do one line
        infoLabel.numberOfLines = 0
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
