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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerNameLabel.text = playerNameString
        playerImageView.layer.cornerRadius = 100
        playerImageURL = "http://www.wnhlwelland.ca/wp-content/uploads/2019/09/DSC_6338.jpg"
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
