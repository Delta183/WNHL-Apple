//
//  SinglePlayerViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-28.
//

import UIKit

class SinglePlayerViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerNameRank: UILabel!
    @IBOutlet weak var playerTeam: UILabel!
    @IBOutlet weak var playerDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
     
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStory.instantiateViewController(withIdentifier: "playerBackViewController") as! SinglePlayerBackViewController
        self.navigationController?.pushViewController(secondVC, animated: false)
        UIView.transition(from: self.view, to: secondVC.view, duration: 0.85, options: [.transitionFlipFromLeft])
     }
    
    @objc func buttonClicked() {
        if let nav = self.navigationController {
                    nav.popViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: nil)
            }
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