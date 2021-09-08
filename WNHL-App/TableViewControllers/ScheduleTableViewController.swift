//
//  ScheduleTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit
import SQLite
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
    var ids: [Int64] = []
    var dates: [String] = []
    var points: [String] = []
    var locations: [String] = []
    var homeTeamIds: [Int] = []
    var awayTeamIds: [Int] = []

    var titles: [String] = []

    
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
        let alertTitle:String = currentCell.titleLabel.text!
        // Create the alert with Team vs Team String as a title and no message
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        
        // Add actions for the alert when it is called. Directions and Set Reminder have default styling
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            // We will have to make a function that could translate these to the exact locations
            // *****
            self.showLocationOnMaps(primaryContactFullAddress: currentCell.locationLabel.text!)
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
        cell.titleLabel.text = self.titles[indexPath.section]
        cell.titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        // Set the alignment of the text with respect to the placements of the labels
        cell.dateLabel.textAlignment = NSTextAlignment.center
        cell.pointsLabel.textAlignment = NSTextAlignment.center
        cell.locationLabel.textAlignment = NSTextAlignment.center
        cell.titleLabel.textAlignment = NSTextAlignment.center
        
        // Setting the images of the Home Team and Away teams Logos
        
        // The extension functions for this needs to be changed to the query function when possible
        // *****
        cell.HomeImage.image = UIImage(named: getImageNameFromTeamNameTable(teamId: self.homeTeamIds[indexPath.section]))
        cell.AwayImage.image = UIImage(named: getImageNameFromTeamNameTable(teamId: self.awayTeamIds[indexPath.section]))
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
        getGames()
        ScheduleTableView.delegate = self
        ScheduleTableView.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getGames(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            //Column Names
            //Table Column Names
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")
            let slug = Expression<String>("slug")
            let seasonID = Expression<String>("seasonID")
            let title = Expression<String>("title")
            let home = Expression<Int64>("home")
            let away = Expression<Int64>("away")
            let homeScore = Expression<Int64>("homeScore")
            let awayScore = Expression<Int64>("awayScore")
            let date = Expression<String>("date")
            let time = Expression<String>("time")
            let location = Expression<Int64>("location")
            //Table Names
            let venues = Table("Venues")
            let teams = Table("Teams")
            let games = Table("Games")
//            for venue in try db.prepare(venues){
//                print("id: \(venue[id]), name: \(venue[name])")
//            }
//            for team in try db.prepare(teams){
//                print("id: \(team[id]), slug: \(team[slug])")
//            }
            let inputDateFormatter = DateFormatter()
            inputDateFormatter.dateFormat = "yyyy-MM-dd"
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd/MM/yyyy"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "h:mm a"
            for game in try db.prepare(games){
                ids.append(game[id])
                let dateString = inputDateFormatter.date(from: game[date])
                dates.append(outputDateFormatter.string(from: dateString!))
                
                let timeFromString = dateFormatter.date(from: game[time])
                let newDate: String = dateFormatter2.string(from: timeFromString!) //pass Date here
                points.append(newDate)
                locations.append(getLocationFromId(locationId: Int(game[location])))
                homeTeamIds.append(Int(game[home]))
                awayTeamIds.append(Int(game[away]))
                titles.append(game[title])
            }
        }
        catch {
            print(error)
        }
        
    }
    
    
}

// This is how you make a function header in Swift
// func methodName(parameterNAme:Type) -> return Type
