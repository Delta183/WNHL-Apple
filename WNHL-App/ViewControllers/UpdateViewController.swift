//
//  UpdateViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class UpdateViewController: UIViewController {
    let screenSize: CGRect = UIScreen.main.bounds
    // Connected the button component to this class such that functionality can be assigned to it.
    @IBOutlet weak var updateAppLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var fontSize:CGFloat = 28

    override func viewDidLoad() {
        if screenSize.width < 414 {
            fontSize = 24
        }
        super.viewDidLoad()
        let button = backButton;
        // Add functionality for when the button is selected from within its bounds
        // It will call the buttonClicked function
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        updateAppLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    // This function will be called when the button is clicked
    @objc func buttonClicked() {
        // Go to previous view controller by dismissing the current
        self.dismiss(animated: true, completion: nil)
    }
}
