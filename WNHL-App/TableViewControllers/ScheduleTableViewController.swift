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
    
    // This IBOutlet variable is a strong variable and is connected to the TableView component in the Schedule View though it is embedded in a container view of said class.
    @IBOutlet var ScheduleTableView: UITableView!
    // The value that dynamically builds the table is derived from the array here, if you can fetch data from the database and populate it here with the same formatting, then that will accomplish the data population as the rest of the UI formatting lies below.
    var ids: [Int64] = []
    var fontSize:CGFloat = 15
    // boolean to track the current state of the season
    var seasonOver = false
    // variable to track the size of the phone screen such that text changes can be made to smaller devices
    let screenSize: CGRect = UIScreen.main.bounds
    // DataFormatters that exist so that the date can be converted to a more human readable format as opposed to how it is stored in the database.
    let inputDateFormatter = DateFormatter()
    let outputDateFormatter = DateFormatter()
    // Same as above but converting the time to a more human readable format.
    let inputTimeFormatter = DateFormatter()
    let outputTimeFormatter = DateFormatter()
    let defaults = UserDefaults.standard
    // The cells are part of a table or collection. In this case it is of a table which is composed of multiple rows and populates downwards much like in the More and Teams page. Much like variables, they must have some identifier or name that is unique.
    let cellReuseIdentifier = "scheduleCell"
    // This is responsible for the height of the spacing between each row in pixels
    let cellSpacingHeight: CGFloat = 30
    
    // These are functions that act like attributes for the Table View. This responsible for the number of sections, for our purposes, all we need is 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.ids.count
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
        // Get the index of the selected row
        let indexPath = ScheduleTableView.indexPathForSelectedRow
        // Using that index, get the cell at said row
        let currentCell = tableView.cellForRow(at: indexPath!) as! ScheduleTableViewCell
        
        // fetch the gameIdString from the ids array
        let gameIdString = String(ids[indexPath!.section])
        // Set a variable such that the name of the alert's first option defaults to Set Reminder since all games are not sent by default.
        var reminderTitle = "Set Reminder"
        if defaults.bool(forKey: gameIdString) == true{
            // If the game is already set, the alert should say Cancel as to reflect the state of the game.
            reminderTitle = "Cancel Reminder"
        }
        // Create a stringe object to hold the title of the alert which takes the format of Team vs Team.
        let alertTitle:String = currentCell.titleLabel.text!
        // Create the alert with Team vs Team String as a title and no message as the alert needs no description
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        
        // Add actions for the alert when it is called. Directions and Set Reminder have default styling
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            // We will have to make a function that could translate these to the exact locations
            // *****
            self.showLocationOnMaps(primaryContactFullAddress: currentCell.locationLabel.text!)
        }))
        // This action will be responsible for the Set Reminder and Cancel Reminder.
        alert.addAction(UIAlertAction(title: reminderTitle, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            if self.defaults.bool(forKey: gameIdString) == true{
                self.deleteNotification(notificationId: gameIdString)
                self.defaults.setValue(false, forKey: gameIdString)
            }
            else{
                let dateTimeString = self.getFullDateTimeStringFromTeamId(gameId: self.ids[indexPath!.section])
                self.scheduleLocal(dateTimeString: dateTimeString, notificationId: gameIdString, titleString: alertTitle)
            }
        }))
        // Cancel has unique styling to denote the level of action it is.
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // Present the alert once it is completely set.
        self.present(alert, animated: true, completion: nil)
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Instantiate the cell as ScheduleTableViewCell object
        let cell = self.ScheduleTableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        // If the screensize is smaller than that of an iPhone 11, the font size will change to reflect that.
        if screenSize.width < 414 {
            fontSize = 14
        }
        // Create a date object given the string mathching the format of the inputDateFormatter
        let dateInputString = inputDateFormatter.date(from: getDateStringFromTeamId(gameId: self.ids[indexPath.section]))
        // Afterwards, create a string that is converted from the previous format to the desired format of the outputDateFormatter
        let dateOutputString:String = outputDateFormatter.string(from: dateInputString!)
        // Same as above but for the time object.
        let timeInputString = inputTimeFormatter.date(from: getTimeStringFromTeamId(gameId: self.ids[indexPath.section]))
        let timeOutputString: String = outputTimeFormatter.string(from: timeInputString!) //pass Date here
        
        // Set the data label to but the converted and more human readable date string.
        cell.dateLabel.text = dateOutputString
        // Set the font of the dateLabel programmatically with a font of 14
        cell.dateLabel.font = UIFont.systemFont(ofSize: 14)
        // Check if the season is over to change the values for the pointsLabel. If the game has finished, display the score, otherwise set the time as the game is upcoming.
        if seasonOver {
            cell.pointsLabel.text = getGameScoreString(gameId: self.ids[indexPath.section])
        }
        else {
            cell.pointsLabel.text = timeOutputString
        }
        // Set the font of the remaining labels as set their text by calling their respective functions from the database extensions
        cell.pointsLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        cell.locationLabel.text = getLocationNameFromId(locationId: getLocationIdFromGameId(gameId: self.ids[indexPath.section]))
        cell.locationLabel.font = UIFont.systemFont(ofSize: fontSize)
        cell.titleLabel.text = getTitleFromGameId(gameId: self.ids[indexPath.section])
        // Offset by -1 so that the text of the Team vs Team string doesn't truncate.
        cell.titleLabel.font = UIFont.systemFont(ofSize: fontSize - 1)
        
        // Set the alignment of the text with respect to the placements of the labels
        cell.dateLabel.textAlignment = NSTextAlignment.center
        cell.pointsLabel.textAlignment = NSTextAlignment.center
        cell.locationLabel.textAlignment = NSTextAlignment.center
        cell.titleLabel.textAlignment = NSTextAlignment.center
        
        // Setting the images of the Home Team and Away teams Logos by calling their image from the database
        cell.HomeImage.image = UIImage(named: getImageNameFromTeamId(teamId: getHomeIdFromGameId(gameId: self.ids[indexPath.section])))
        cell.AwayImage.image = UIImage(named: getImageNameFromTeamId(teamId: getAwayIdFromGameId(gameId: self.ids[indexPath.section])))
        // This makes it so that the selection of cells in the table views does not have a graphical effect.
        cell.noSelectionStyle()
        // set the background color of the table cells to be wite
        cell.backgroundColor = UIColor.white
        // Corner radius is used to make the edges much rounder than normal.
        cell.layer.cornerRadius = 24
        cell.clipsToBounds = true
        
        return cell
    }
    
    override func viewDidLoad() {
        // Set the format for the input and output of the date formatter objects
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        outputDateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        inputTimeFormatter.dateFormat = "HH:mm:ss"
        outputTimeFormatter.dateFormat = "h:mm a"
        getGameIds()
        deletePastSetNotifications(idList: self.ids)
        updateScheduledGamesFromPreferences()
        ScheduleTableView.delegate = self
        ScheduleTableView.dataSource = self
        // As the app has already launched once, this can be set as true.
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getGameIds(){
        let currentTime = Date()
        let dateFormatter = ISO8601DateFormatter()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            //Table Column Names
            let id = Expression<Int64>("id")
            let date = Expression<String>("date")
            let time = Expression<String>("time")
            //Table Names
            let games = Table("Games")
            //Check if the game has happened or not
            for game in try db.prepare(games){
                //Get the Game Date and Time
                let isoDate = game[date]+"T"+game[time]+"+0000"
                let gameDate = dateFormatter.date(from: isoDate)!
                if currentTime < gameDate {
                    ids.append(game[id])
                }
            }
            if ids.isEmpty {
                seasonOver = true
                for game in try db.prepare(games){
                    ids.append(game[id])
                }
            }
        }
        catch {
            print(error)
        }
    }
}
