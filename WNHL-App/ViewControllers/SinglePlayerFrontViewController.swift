//
//  SinglePlayerBackViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-28.
//

import UIKit

class SinglePlayerFrontViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var whiteLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    var playerImageURL:String!
    // This is String variable used to transfer information from the previous table view in order to populate this view with the correct specific player data.
    // This will be sent to the SinglePlayerBackViewController to allow that view to populate its data with the correct player information.
    var playerID:Int64!
    var playerNameString:String! 
    
    override func viewDidLoad() {
        playerNameLabel.text = playerNameString
        playerNumberLabel.text = String(playerID)
        // The white label is behind the playerNumberLabel and playerNameLabel
        // It has a thick border with an orange colour to simulate a sort of cell
        whiteLabel.layer.borderWidth = 10.0
        whiteLabel.layer.borderColor = UIColor.systemOrange.cgColor
        playerImageURL = "http://www.wnhlwelland.ca/wp-content/uploads/2019/09/DSC_6338.jpg"
        let playerImage = UIImage(url: URL(string: playerImageURL))
        if playerImage == nil{
            playerImageView.contentMode = .scaleAspectFit
            playerImageView.image = UIImage(named: "WNHL_Logo")
        }else{
            playerImageView.image = playerImage
        }
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Set the destination view controller to be that of the PlayerBackViewController
        let secondVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "playerBackViewController") as! SinglePlayerBackViewController
        // Set the data of that view controller's analog string from this class with data also from this class
        secondVC.playerNameString = self.playerNameString
        // Push that destination view controller onto the Navigation controller stack
        self.navigationController?.pushViewController(secondVC, animated: false)
        // Make the transition with the appropriate start and end points and animations.
        UIView.transition(from: self.view, to: secondVC.view, duration: 0.85, options: [.transitionFlipFromLeft])
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
