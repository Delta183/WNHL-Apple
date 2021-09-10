//
//  SingleTeamTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit
import SQLite

class SingleTeamTableViewController: UITableViewController {
    let defaults = UserDefaults.standard
    let reuseIdentifier = "gameListingCell"
    @IBOutlet var TeamScheduleTableView: UITableView!
    let cellSpacingHeight: CGFloat = 30
    
    var ids: [Int64] = []
    var dates: [String] = []
    var points: [String] = []
    var locations: [String] = []
    var homeTeamIds: [Int] = []
    var awayTeamIds: [Int] = []
    var dateObjects: [String] = []
    var titles: [String] = []

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
        let cellIdString = String(ids[indexPath!.section])
        
        let alertTitle:String = currentCell.titleLabel.text!
        // Create the alert with Team vs Team String as a title and no message
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        var reminderTitle = "Set Reminder"
        if defaults.bool(forKey: cellIdString) == true{
            reminderTitle = "Cancel Reminder"
        }
        // Add actions for the alert when it is called. Directions and Set Reminder have default styling
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            // We will have to make a function that could translate these to the exact locations
            // *****
            self.showLocationOnMaps(primaryContactFullAddress: currentCell.locationLabel.text!)
        }))
        alert.addAction(UIAlertAction(title: reminderTitle, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            if self.defaults.bool(forKey: cellIdString) == true{
                self.deleteNotification(notificationId: cellIdString)
                self.defaults.setValue(false, forKey: cellIdString)
            }
            else{
                // var dateString = String()
                // dateString = "2021-09-08 22:15:00"
                self.scheduleLocal(dateTimeString: self.dateObjects[indexPath!.section], notificationId: cellIdString)
                self.defaults.setValue(true, forKey: cellIdString)
                //self.scheduleLocalTest()
            }
        }))
        // Cancel has unique styling to denote the level of action it is.
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // Present the alert once it is completely set.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TeamScheduleTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SingleTeamTableViewCell
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
        cell.homeImage.image = UIImage(named: getImageNameFromTeamNameTable(teamId: self.homeTeamIds[indexPath.section]))
        cell.awayImage.image = UIImage(named: getImageNameFromTeamNameTable(teamId: self.awayTeamIds[indexPath.section]))
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
        deletePastSetNotifications(idList: ids, dateList: dateObjects)
        TeamScheduleTableView.delegate = self
        TeamScheduleTableView.dataSource = self
        super.viewDidLoad()
        
    }
    
    func getGames(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            //Column Names
            //Table Column Names
            let id = Expression<Int64>("id")
            let title = Expression<String>("title")
            let home = Expression<Int64>("home")
            let away = Expression<Int64>("away")
            let homeScore = Expression<Int64>("homeScore")
            let awayScore = Expression<Int64>("awayScore")
            let date = Expression<String>("date")
            let time = Expression<String>("time")
            let location = Expression<Int64>("location")
            //Table Names
            let games = Table("Games")
//
            let inputDateFormatter = DateFormatter()
            inputDateFormatter.dateFormat = "yyyy-MM-dd"
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "h:mm a"
            for game in try db.prepare(games){
                ids.append(game[id])
                
                let dateString = inputDateFormatter.date(from: game[date])
                dates.append(outputDateFormatter.string(from: dateString!))
                
                let dateFromString = dateFormatter.date(from: game[time])
                let newTime: String = dateFormatter2.string(from: dateFromString!) //pass Date here
                points.append(newTime)
                
                locations.append(getLocationFromId(locationId: game[location]))
                homeTeamIds.append(Int(game[home]))
                awayTeamIds.append(Int(game[away]))
                titles.append(game[title])
                dateObjects.append(game[date] + " " + game[time])
            }
        }
        catch {
            print(error)
        }
        
    }
}
