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
        yearsLabel.text = "2020-2021"
        scheduleTitleLabel.text = "Regular Season"
        // Do any additional setup after loading the view.
    }
}

