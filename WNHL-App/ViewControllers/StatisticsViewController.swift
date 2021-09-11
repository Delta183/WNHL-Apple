//
//  StatisticsViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class StatisticsViewController: UIViewController {
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var statsLabel: UILabel!
    var fontSize:CGFloat = 28

    override func viewDidLoad() {
        super.viewDidLoad()
        if screenSize.width < 414 {
            fontSize = 22
        }
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        statsLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
