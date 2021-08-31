//
//  TeamTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-23.
//

import UIKit

class TeamTableViewController: UITableViewController {
    
    @IBOutlet var teamTableView: UITableView!
    var teams = ["ATLAS STEELERS", "TOWNLINE TUNNELERS", "CROWN ROOM KINGS", "DAIN CITY DUSTERS",  "LINCOLN STREET LEGENDS"]
    var teamNameString:String!
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
        let indexPath = teamTableView.indexPathForSelectedRow
        let rowNumber:Int = indexPath!.row as Int
        let currentCell = self.teamTableView.cellForRow(at:indexPath!) as! TeamTableViewCell
        //print(rowNumber)
        if rowNumber == 0 {
            teamNameString = currentCell.teamNameLabel.text
            self.performSegue(withIdentifier: "singleTeamSegue", sender: self)
        }
        else if rowNumber == 1 {
            teamNameString = currentCell.teamNameLabel.text
            self.performSegue(withIdentifier: "singleTeamSegue", sender: self)
        }
        else if rowNumber == 2 {
            teamNameString = currentCell.teamNameLabel.text
            self.performSegue(withIdentifier: "singleTeamSegue", sender: self)
        }
        else if rowNumber == 3 {
            teamNameString = currentCell.teamNameLabel.text
            self.performSegue(withIdentifier: "singleTeamSegue", sender: self)
        }
        else{
            teamNameString = currentCell.teamNameLabel.text
            self.performSegue(withIdentifier: "singleTeamSegue", sender: self)
        }
     
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamTableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
        cell.noSelectionStyle()
        cell.teamNameLabel.text = teams[indexPath.row]
        cell.teamNameLabel.textColor = UIColor.white
        cell.teamNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.chevronImage.image = UIImage(systemName: "chevron.right")
        cell.chevronImage.tintColor = UIColor.white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

           // Get a reference to the second view controller
           let secondViewController = segue.destination as! SingleTeamViewController

           // Set a variable in the second view controller with the String to pass
            secondViewController.teamNameString = teamNameString
       }

}
