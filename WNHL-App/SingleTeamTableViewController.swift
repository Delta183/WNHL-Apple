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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dates.count
    }
    
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
        // Segue to the second view controller
        let indexPath = TeamScheduleTableView.indexPathForSelectedRow
        let sectionNumber:String = String(indexPath!.section + 1)
        //print(rowNumber)
        let alert = UIAlertController(title: "Game " + sectionNumber, message: "", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Set Reminder", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TeamScheduleTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SingleTeamTableViewCell

        cell.noSelectionStyle()
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
        // The text label is populated with whatever data is at this index in the games array at the top of the file.
        // indexPath.row seems to start from 0 to n.
        cell.dateLabel.textAlignment = NSTextAlignment.center
        cell.pointsLabel.textAlignment = NSTextAlignment.center
        cell.locationLabel.textAlignment = NSTextAlignment.center
        cell.homeTeamLabel.textAlignment = NSTextAlignment.right
        cell.awayTeamLabel.textAlignment = NSTextAlignment.left
        
        cell.homeImage.image = UIImage(named: getImageFromTeamName(teamName: self.teams1[indexPath.section]))
        cell.awayImage.image = UIImage(named: getImageFromTeamName(teamName: self.teams2[indexPath.section]))
        
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
