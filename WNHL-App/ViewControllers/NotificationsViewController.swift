//
//  NotificationsViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class NotificationsViewController: UIViewController {
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    var fontSize:CGFloat = 28

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        // The info label is set here as opposed to setting a static text view on the Notifications View
        infoLabel.text = "Select a Team to receive notifications for Upcoming Games.\nTo stop receiving notifications, deselect the Team."
        // Removing the limit is done through setting number of lines to 0 as labels initially can only do one line
        infoLabel.numberOfLines = 0
        if screenSize.width < 414 {
            fontSize = 24
        }
        notificationLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NotificationsTableViewController,
           segue.identifier == "notificationTableSegue" {
            vc.delegate = self
        }
    }
}


