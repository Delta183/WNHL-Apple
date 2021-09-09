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
    // This string will be used to preserve the string from the teams array such that it can be sent to the child view controller.
    var teamNameString:String!
    
    // Set the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // set the number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    // Set functionality for when a row is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch the index of the selected row
        let indexPath = teamTableView.indexPathForSelectedRow
        // Using that index, get the cell object itself from the Table View
        let currentCell = self.teamTableView.cellForRow(at:indexPath!) as! TeamTableViewCell
        // Set the variable as the text of the teamNameLabel of that cell.
        teamNameString = currentCell.teamNameLabel.text
        // Perform the segue to the next/child view controller
        self.performSegue(withIdentifier: "singleTeamSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamTableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
        cell.noSelectionStyle()
        
        cell.teamNameLabel.text = teams[indexPath.row]
        cell.teamNameLabel.textColor = UIColor.white
        cell.teamNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        cell.chevronImage.image = UIImage(systemName: "chevron.right")
        // Tint colour in particular will change the base colour of blue for the system images to white
        cell.chevronImage.tintColor = UIColor.white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // This function will be called just prior to the segue performed in the didSelectRowAt function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get a reference to the second view controller
        let secondViewController = segue.destination as! SingleTeamViewController
        
        // Set a variable in the second view controller with the String to pass
        secondViewController.teamNameString = teamNameString
    }
    
    
    
}
