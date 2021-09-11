//
//  ScrollSingleTeamViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-11.
//

import UIKit

class ScrollSingleTeamViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var teamNameString:String!
    var teamId:Int64!

    var SingleTeamTableViewController: SingleTeamTableViewController?
    var FirstSingleTeamSpreadsheetViewController: FirstSingleTeamSpreadsheetViewController?
    var SecondSingleTeamSpreadsheetViewController: SecondSingleTeamSpreadsheetViewController?
    override func viewDidLoad() {
        self.view.backgroundColor = getColorFromTeamId(teamNameString: teamNameString)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+440)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let vc = segue.destination as? SingleTeamTableViewController {
              // save reference to VC embedded in Container View
              self.SingleTeamTableViewController = vc
            self.SingleTeamTableViewController?.teamId = self.teamId
          }
        if let vc = segue.destination as? FirstSingleTeamSpreadsheetViewController {
            // save reference to VC embedded in Container View
            self.FirstSingleTeamSpreadsheetViewController = vc
            self.FirstSingleTeamSpreadsheetViewController?.teamId = self.teamId
        }
        if let vc = segue.destination as? SecondSingleTeamSpreadsheetViewController {
            // save reference to VC embedded in Container View
            self.SecondSingleTeamSpreadsheetViewController = vc
            self.SecondSingleTeamSpreadsheetViewController?.teamId = self.teamId
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
