//
//  ScheduleTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit
import UserNotifications
// View Controllers represent each screen, A basic screen is known as a View Controller but a view entirely devoted to say a TableView is a TableViewController. Thus this class is responsible for affecting strictly the table on the Schedule screen.
class ScheduleTableViewController: UITableViewController {
    
    // The cells are part of a table or collection. In this case it is of a table which is composed of multiple rows and populates downwards much like in the More and Teams page. Much like variables, they must have some identifier or name that is unique.
    let cellReuseIdentifier = "scheduleCell"
    // This is responsible for the height of the spacing between each row in pixels
    let cellSpacingHeight: CGFloat = 30
    // This IBOutlet variable is a strong variable and is connected to the TableView component in the Schedule View though it is embedded in a container view of said class.
    @IBOutlet var ScheduleTableView: UITableView!
    // The value that dynamically builds the table is derived from the array here, if you can fetch data from the database and populate it here with the same formatting, then that will accomplish the data population as the rest of the UI formatting lies below.
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
    
    // These are functions that act like attributes for the Table View. This responsible for the number of sections, for our purposes, all we need is 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dates.count
    }
    
    // This function will set the number of rows in each section.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // There is just one row in every section and thus we return 1
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
    
    // This function monitors the selection of a row in the table
    // Depending on which game the user selected, then an alert will appear and prompt various choices. Directions, Set Reminder and Cancel
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = ScheduleTableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! ScheduleTableViewCell
        let alertTitle:String = String(currentCell.homeTeamLabel.text!) + " vs " + String(currentCell.awayTeamLabel.text!)
        // Create the alert with Team vs Team String as a title and no message
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        
        // Add actions for the alert when it is called. Directions and Set Reminder have default styling
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            let fullAddress = "Brock University, Sir Isaac Brock Way, St. Catharines, ON"
            self.showLocationOnMaps(primaryContactFullAddress: fullAddress)
        }))
        alert.addAction(UIAlertAction(title: "Set Reminder", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            var dateString = String()
            dateString = "2021-09-06 00:32:50"
            self.scheduleLocal(dateTimeString: dateString)
            //self.scheduleLocalTest()
        }))
        // Cancel has unique styling to denote the level of action it is.
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // Present the alert once it is completely set.
        self.present(alert, animated: true, completion: nil)
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ScheduleTableViewCell is custom made by myself that has 2 image views one text label, highlighting and right clicking the ScheduleTableViewCell and jumping to Definition should display the outlets that the Custom cell class contains.
        // Think classes in Java, housing a bunch of elements repeatedly used in a singular class.
        let cell = self.ScheduleTableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        // Once the cell is fetched, modify it as needed
        // The imageViews and text labels were given unique identifiers being HomeImage and AwayImage for the images and scheduleText for the text label.
        // In this table, there are multiple sections with 1 row as opposed to 1 section with many rows and as a result, the indexPath is to be tracked by section and not row
        cell.dateLabel.text = self.dates[indexPath.section]
        // Set the font of the dateLabel programmatically with a font of 15
        cell.dateLabel.font = UIFont.systemFont(ofSize: 15)
        cell.pointsLabel.text = self.points[indexPath.section]
        cell.pointsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cell.locationLabel.text = self.locations[indexPath.section]
        cell.locationLabel.font = UIFont.systemFont(ofSize: 15)
        cell.homeTeamLabel.text = self.teams1[indexPath.section]
        cell.homeTeamLabel.font = UIFont.systemFont(ofSize: 14)
        cell.awayTeamLabel.text = self.teams2[indexPath.section]
        cell.awayTeamLabel.font = UIFont.systemFont(ofSize: 14)
        
        // Set the alignment of the text with respect to the placements of the labels
        cell.dateLabel.textAlignment = NSTextAlignment.center
        cell.pointsLabel.textAlignment = NSTextAlignment.center
        cell.locationLabel.textAlignment = NSTextAlignment.center
        cell.homeTeamLabel.textAlignment = NSTextAlignment.right
        cell.awayTeamLabel.textAlignment = NSTextAlignment.left
        
        // Setting the images of the Home Team and Away teams Logos
        cell.HomeImage.image = UIImage(named: getImageNameFromTeamNameTable(teamName: self.teams1[indexPath.section]))
        cell.AwayImage.image = UIImage(named: getImageNameFromTeamNameTable(teamName: self.teams2[indexPath.section]))
        // This makes it so that the selection of cells in the table views does not have a graphical effect.
        cell.noSelectionStyle()
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 0
        // Corner radius is used to make the edges much rounder than normal.
        cell.layer.cornerRadius = 24
        cell.clipsToBounds = true
        
        return cell
    }
    
    override func viewDidLoad() {
        ScheduleTableView.delegate = self
        ScheduleTableView.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

// This is how you make a function header in Swift
// func methodName(parameterNAme:Type) -> return Type
