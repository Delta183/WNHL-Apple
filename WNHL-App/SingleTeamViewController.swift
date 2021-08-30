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
        if teamNameString == "ATLAS STEELERS"{
            teamLogo.image = UIImage(named: "steelers_logo")
        }
        else if teamNameString == "TOWNLINE TUNNELERS"{
            teamLogo.image = UIImage(named: "townline_logo")
        }
        else if teamNameString == "CROWN ROOM KINGS"{
            teamLogo.image = UIImage(named: "crownRoom_logo")
        }
        else if teamNameString == "DAIN CITY DUSTERS"{
            teamLogo.image = UIImage(named: "dusters_logo")
        }
        else if teamNameString == "LINCOLN STREET LEGENDS"{
            teamLogo.image = UIImage(named: "legends_logo")
        }
        else{
            teamLogo.image = UIImage(named: "WNHL_Logo")
        }
       
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
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
