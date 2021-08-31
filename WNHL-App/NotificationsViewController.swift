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
        infoLabel.text = "Select a Team to receive notifications for Upcoming Games.\nTo stop receiving notifications, deselect the Team."
        infoLabel.numberOfLines = 0
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
