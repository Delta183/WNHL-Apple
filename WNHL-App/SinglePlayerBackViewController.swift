//
//  SinglePlayerBackViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-28.
//

import UIKit

class SinglePlayerBackViewController: UIViewController {
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var whiteLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    var playerNameString:String!
    override func viewDidLoad() {
        playerNameLabel.text = playerNameString
        whiteLabel.layer.borderWidth = 10.0
        whiteLabel.layer.borderColor = UIColor.systemOrange.cgColor
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstVC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count ?? 2) - 2] as? SinglePlayerViewController
        navigationController?.popViewController(animated: false)
        UIView.transition(from: self.view, to: (firstVC?.view)!, duration: 0.85, options: [.transitionFlipFromRight])
        
        

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
