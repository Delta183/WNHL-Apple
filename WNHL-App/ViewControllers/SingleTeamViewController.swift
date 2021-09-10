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
    var teamId:Int64!
    // The teamId is successfully passed from the TeamTableViewController
    
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

