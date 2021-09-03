//
//  UpdateViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class UpdateViewController: UIViewController {
    // Connected the button component to this class such that functionality can be assigned to it.
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = backButton;
        // Add functionality for when the button is selected from within its bounds
        // It will call the buttonClicked function
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    }
    
    // This function will be called when the button is clicked
    @objc func buttonClicked() {
        // Go to previous view controller by dismissing the current
        self.dismiss(animated: true, completion: nil)
    }
}
