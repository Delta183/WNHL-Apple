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
    var fontSize:CGFloat = 28

    override func viewDidLoad() {
        yearsLabel.text = "1999-2000"
        yearsLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        scheduleTitleLabel.text = "Extreme Season"
        scheduleTitleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        super.viewDidLoad()
    }
}

