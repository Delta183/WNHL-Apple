//
//  SingleTeamTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit

class SingleTeamTableViewController: UITableViewController {
    let reuseIdentifier = "gameListingCell"
    @IBOutlet var TeamScheduleTableView: UITableView!
    let cellSpacingHeight: CGFloat = 30
    
    var dates: [String] = ["Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",]
    var points: [String] = ["2 - 2",
                            "2 - 2",
                            "2 - 2",
                            "2 - 2",
                            "2 - 2",]
    var locations: [String] = ["Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",]
    var teams1: [String] = ["Lincoln Street Legends",
                            "Dain City Dusters",
                            "Atlas Steelers",
                            "Crown Room Kings",
                            "Townline Tunnelers"]
    var teams2: [String] = ["BOI",
                            "Lincoln Street Legends",
                            "Atlas Steelers",
                            "Townline Tunnelers",
                            "Merritt Islanders",]
    // MARK: - Table view data source
    
    // Set the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dates.count
    }
    
    // Set the number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = TeamScheduleTableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! SingleTeamTableViewCell
        let alertTitle:String = String(currentCell.homeTeamLabel.text!) + " vs " + String(currentCell.awayTeamLabel.text!)
        // Create the alert with Team vs Team String as a title and no message
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        
        // Add actions for the alert when it is called. Directions and Set Reminder have default styling
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Set Reminder", style: UIAlertAction.Style.default, handler: nil))
        // Cancel has unique styling to denote the level of action it is.
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // Present the alert once it is completely set.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TeamScheduleTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SingleTeamTableViewCell
        cell.dateLabel.text = self.dates[indexPath.section]
        cell.dateLabel.font = UIFont.systemFont(ofSize: 15)
        cell.pointsLabel.text = self.points[indexPath.section]
        cell.pointsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cell.locationLabel.text = self.locations[indexPath.section]
        cell.locationLabel.font = UIFont.systemFont(ofSize: 15)
        cell.homeTeamLabel.text = self.teams1[indexPath.section]
        cell.homeTeamLabel.font = UIFont.systemFont(ofSize: 15)
        cell.awayTeamLabel.text = self.teams2[indexPath.section]
        cell.awayTeamLabel.font = UIFont.systemFont(ofSize: 15)
        
        cell.dateLabel.textAlignment = NSTextAlignment.center
        cell.pointsLabel.textAlignment = NSTextAlignment.center
        cell.locationLabel.textAlignment = NSTextAlignment.center
        cell.homeTeamLabel.textAlignment = NSTextAlignment.right
        cell.awayTeamLabel.textAlignment = NSTextAlignment.left
        
        cell.homeImage.image = UIImage(named: getImageNameFromTeamNameTable(teamName: self.teams1[indexPath.section]))
        cell.awayImage.image = UIImage(named: getImageNameFromTeamNameTable(teamName: self.teams2[indexPath.section]))
        
        cell.noSelectionStyle()
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 24
        cell.clipsToBounds = true
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TeamScheduleTableView.delegate = self
        TeamScheduleTableView.dataSource = self
    }
}
