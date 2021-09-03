//
//  SingleTeamViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class SingleTeamViewController: UIViewController {
    // These correspond to the matching components on the View connected to the class. In this case this is linked the storyboard for a singular team.
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    // this string exists such that data can be passed to this class as opposed to outright setting the teamNameLabel from outside the class. It is not an outlet and exists in this class and not the storyboard
    var teamNameString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Effectively allow the scroll view to actually scroll by increasing the size of the content to be bigger than the base height
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+440)
        teamNameLabel.text = teamNameString
        teamLogo.image = UIImage(named: getImageNameFromTeamName(teamName: teamNameString))
        self.view.backgroundColor = getColorFromTeamId(teamNameString: teamNameString)
        
        let button = backButton;
        // Add functionality of the onClick analog to the button specifically when the button has been pressed within its bounds (.touchUpInside)
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    }
    
    // This function will be called when the button is clicked
    @objc func buttonClicked() {
        // Go to previous view controller by dismissing the current
        self.dismiss(animated: true, completion: nil)
    }
}

// Function to give the view a special background colour dependent on the team that was selected.
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

