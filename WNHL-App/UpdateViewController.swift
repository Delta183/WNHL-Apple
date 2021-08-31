//
//  UpdateViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
