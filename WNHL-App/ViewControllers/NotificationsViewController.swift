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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NotificationsTableViewController,
           segue.identifier == "notificationTableSegue" {
            vc.delegate = self
        }
    }
}

extension NotificationsViewController:ChildToParentProtocol {
    
    func buttonClickedByUser() {
        print("bababooey")
    }
    func needToPassInfoToParent(with isNowChecked:Bool, teamNameString:String) {
        if isNowChecked{
            self.showToast(message: teamNameString + " Notifications ON", font: .systemFont(ofSize: 15.0))
        }
        else{
            self.showToast(message: teamNameString + " Notifications OFF", font: .systemFont(ofSize: 15.0))
        }
    }
}

// Put to parent view
extension UIViewController{
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 55, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
