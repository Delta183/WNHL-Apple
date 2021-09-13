//
//  SinglePlayerViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-28.
//

import UIKit

class SinglePlayerBackViewController: UIViewController {
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTeamLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerDescription: UITextView!
    var playerNameString:String!
    var playerImageURL:String!
    var playerID: Int64!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerNameLabel.text = playerNameString
        playerNumberLabel.text = getPlayerNumberFromId(playerId: playerID)
        playerDescription.text = getPlayerContentFromId(playerId: playerID).replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "").replacingOccurrences(of: "&#8212;", with: "-").replacingOccurrences(of: "<p style=\"text-align:left;\">", with: "").replacingOccurrences(of: "&#8220;", with: "\"").replacingOccurrences(of: "&#8221;", with: "\"").replacingOccurrences(of: "&#8217;", with: "'")
        playerTeamLabel.text = getPlayerCurrTeamFromId(playerId: playerID)
        playerImageView.layer.cornerRadius = 100
        playerImageURL = getPlayerImageFromId(playerId: playerID)
        let playerImage = UIImage(url: URL(string: playerImageURL))
        if playerImage == nil{
            playerImageView.image = UIImage(named: "WNHL_Logo")
        }else{
            playerImageView.image = playerImage
        }
    }
    
    // This function is called when any spot on the screen has been touched that isn't an interactable component
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Utilizing the navigation controller, retrieve the initial ViewController and then transition into that view while popping the current view.
        let firstVC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count ?? 2) - 2] as? SinglePlayerFrontViewController
        navigationController?.popViewController(animated: false)
        // Settting the properties of the transition as in where the transition will begin and end in addition to the type of animation.
        UIView.transition(from: self.view, to: (firstVC?.view)!, duration: 0.85, options: [.transitionFlipFromRight])
    }
}
