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
        self.view.backgroundColor = getColorFromTeamId(teamNameString: teamNameString)
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

func getColorFromTeamId(teamNameString: String) -> UIColor{
    if teamNameString.caseInsensitiveCompare("Atlas Steelers")  == ComparisonResult.orderedSame{
        return UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    }
    else if teamNameString.caseInsensitiveCompare("Townline Tunnelers") == ComparisonResult.orderedSame{
        return UIColor.systemBlue
    }
    else if teamNameString.caseInsensitiveCompare("Crown Room Kings") == ComparisonResult.orderedSame{
        return UIColor.black
    }
    else if teamNameString.caseInsensitiveCompare("Dain City Dusters") == ComparisonResult.orderedSame{
        return UIColor.red
    }
    else if teamNameString.caseInsensitiveCompare("Lincoln Street Legends") == ComparisonResult.orderedSame{
        // This will allow the creation of custom colours through changing the numerators
        return UIColor(red: 10.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    }
    else if teamNameString.caseInsensitiveCompare("Merritt Islanders") == ComparisonResult.orderedSame{
        return UIColor.systemGray2
    }
    else{
        return UIColor.systemOrange
    }
}

