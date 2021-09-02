//
//  SingleTeamViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class SingleTeamViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var teamNameString:String!
    var teams = ["ATLAS STEELERS", "TOWNLINE TUNNELERS", "CROWN ROOM KINGS", "DAIN CITY DUSTERS",  "LINCOLN STREET LEGENDS"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+440)
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        teamNameLabel.text = teamNameString
        teamLogo.image = UIImage(named: getImageNameFromTeamName(teamName: teamNameString))
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

