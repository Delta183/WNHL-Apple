//
//  ViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-07-26.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var yearsLabel: UITextField!
    @IBOutlet weak var scheduleTitleLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        yearsLabel.text = "1999-2000"
        scheduleTitleLabel.text = "Extreme Season"
        // Do any additional setup after loading the view.
    }
}

