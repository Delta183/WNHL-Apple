//
//  StandingsViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-03.
//

import UIKit

class StandingsViewController: UIViewController {

    @IBOutlet weak var StandingsScrollView: UIScrollView!
    override func viewDidLoad() {
        StandingsScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+550)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
