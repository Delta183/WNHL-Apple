//
//  SingleTeamTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit
import SQLite

class SingleTeamTableViewController: UITableViewController {
    let inputDateFormatter = DateFormatter()
    let outputDateFormatter = DateFormatter()
    let inputTimeFormatter = DateFormatter()
    let outputTimeFormatter = DateFormatter()

    let defaults = UserDefaults.standard
    let reuseIdentifier = "gameListingCell"
    @IBOutlet var TeamScheduleTableView: UITableView!
    let cellSpacingHeight: CGFloat = 30
    var teamId:Int64!
    var ids: [Int64] = []
    // MARK: - Table view data source
    
    // Set the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.ids.count
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
        let gameIdString = String(ids[indexPath!.section])
        
        let alertTitle:String = currentCell.titleLabel.text!
        // Create the alert with Team vs Team String as a title and no message
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        var reminderTitle = "Set Reminder"
        if defaults.bool(forKey: gameIdString) == true{
            reminderTitle = "Cancel Reminder"
        }
        // Add actions for the alert when it is called. Directions and Set Reminder have default styling
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            // We will have to make a function that could translate these to the exact locations
            // *****
            self.showLocationOnMaps(primaryContactFullAddress: currentCell.locationLabel.text!)
        }))
        alert.addAction(UIAlertAction(title: reminderTitle, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            if self.defaults.bool(forKey: gameIdString) == true{
                self.deleteNotification(notificationId: gameIdString)
                self.defaults.setValue(false, forKey: gameIdString)
            }
            else{
                // var dateString = String()
                // dateString = "2021-09-08 22:15:00"
                let dateTimeString = self.getFullDateTimeStringFromTeamId(gameId: self.ids[indexPath!.section])
                self.scheduleLocal(dateTimeString: dateTimeString, notificationId: gameIdString)
                self.defaults.setValue(true, forKey: gameIdString)
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
        let dateInputString = inputDateFormatter.date(from: getDateStringFromTeamId(gameId: self.ids[indexPath.section]))
        let dateOutputString:String = outputDateFormatter.string(from: dateInputString!)
        cell.dateLabel.text = dateOutputString
        // Set the font of the dateLabel programmatically with a font of 15
        cell.dateLabel.font = UIFont.systemFont(ofSize: 15)
        
        let timeInputString = inputTimeFormatter.date(from: getTimeStringFromTeamId(gameId: self.ids[indexPath.section]))
        let timeOutputString: String = outputTimeFormatter.string(from: timeInputString!) //pass Date here
        cell.pointsLabel.text = timeOutputString
        cell.pointsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cell.locationLabel.text = getLocationNameFromId(locationId: getLocationIdFromGameId(gameId: self.ids[indexPath.section]))
        cell.locationLabel.font = UIFont.systemFont(ofSize: 15)
        cell.titleLabel.text = getTitleFromGameId(gameId: self.ids[indexPath.section])
        cell.titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        // Set the alignment of the text with respect to the placements of the labels
        cell.dateLabel.textAlignment = NSTextAlignment.center
        cell.pointsLabel.textAlignment = NSTextAlignment.center
        cell.locationLabel.textAlignment = NSTextAlignment.center
        cell.titleLabel.textAlignment = NSTextAlignment.center
        
        // Setting the images of the Home Team and Away teams Logos
        
        // The extension functions for this needs to be changed to the query function when possible
        // *****
        cell.homeImage.image = UIImage(named: getImageNameFromTeamId(teamId: getHomeIdFromGameId(gameId: self.ids[indexPath.section])))
        cell.awayImage.image = UIImage(named: getImageNameFromTeamId(teamId: getAwayIdFromGameId(gameId: self.ids[indexPath.section])))
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
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        outputDateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        inputTimeFormatter.dateFormat = "HH:mm:ss"
        outputTimeFormatter.dateFormat = "h:mm a"
        getGameIds()
        deletePastSetNotifications(idList: ids)
        TeamScheduleTableView.delegate = self
        TeamScheduleTableView.dataSource = self
        super.viewDidLoad()
    }
    
    
    func getGameIds(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            //Table Column Names
            let id = Expression<Int64>("id")
            let home = Expression<Int64>("home")
            let away = Expression<Int64>("away")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games){
                //if home or away id matches the team id add the game to the list
                if game[home] == 940 || game[away] == 940{
                    ids.append(game[id])
                }
            }
        }
        catch {
            print(error)
        }
    }
}
