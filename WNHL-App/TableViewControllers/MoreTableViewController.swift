//
//  MoreTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit

class MoreTableViewController: UITableViewController {
    @IBOutlet var MoreTableView: UITableView!
    var entries = ["PLAYERS", "STATISTICS","YOUTUBE", "TWITTER" ,"WNHL FANTASY", "NOTIFICATION SETTINGS", "UPDATE"]
    var iconNames = ["person.fill", "waveform.path.ecg", "youtube_logo","twitter_logo", "star.circle.fill", "bell.fill","clock.arrow.circlepath"]
    var reuseIdentifier = "MoreCell"
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
        let indexPath = MoreTableView.indexPathForSelectedRow
        let rowNumber:Int = indexPath!.row as Int
        // The if-else block is to give each button specific functionality based off their indices
        // Players button
        if rowNumber == 0 {
            self.performSegue(withIdentifier: "playersSegue", sender: self)
        }
        // Statistics button
        else if rowNumber == 1 {
            self.performSegue(withIdentifier: "statisticsSegue", sender: self)
        }
        // Youtube button
        else if rowNumber == 2 {
            // This string represents the id part of the Youtube URL for channels
            let youtubeChannelID:String = "UCklG51DEXWN6RodvW8Mj3cg"
            goToYoutubeChannel(youtubeChannelId: youtubeChannelID)
        }
        // Twitter button
        else if rowNumber == 3 {
            // This is a string representing the handle of the channel.
            let twitterUserID:String = "WNHL2"
            goToTwitterAccount(twitterUserID: twitterUserID)
        }
        // WNHL Fantasy button
        else if rowNumber == 4 {
            goToFantasySpreadsheet()
        }
        // Notifications Settings button
        else if rowNumber == 5 {
            self.performSegue(withIdentifier: "notificationSegue", sender: self)
        }
        // Otherwise the last button by default is the Update button
        else{
            self.performSegue(withIdentifier: "updateSegue", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoreTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MoreTableViewCell
        cell.moreTextLabel.text = entries[indexPath.row]
        cell.moreTextLabel.textColor = UIColor.white
        cell.moreTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        cell.chevronImage.image = UIImage(systemName: "chevron.right")
        cell.chevronImage.tintColor = UIColor.white
        
        cell.iconImage.image = UIImage(systemName: iconNames[indexPath.row])
        // The names in the iconNames array are not system images and are actually custom image sets and thus will be set to nil
        // As a result, check if the image set is still nil after the previous line
        if cell.iconImage.image == nil {
            // If it is still nill, set the image with the same strings but searching the custom images.
            if iconNames[indexPath.row] == "youtube_logo"{
                cell.iconImage.image = UIImage(named: "youtube_logo")
            }
            else{
                cell.iconImage.image = UIImage(named: "twitter_logo")
            }
        }
        cell.iconImage.tintColor = UIColor.white
        cell.noSelectionStyle()
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// This function will take the string given representing a Youtube Channel ID and use it to take the user to it
func goToYoutubeChannel(youtubeChannelId:String) {
    // appURL is the url for the Youtube app in particular
    let appURL = NSURL(string: "youtube://www.youtube.com/channel/\(youtubeChannelId)")!
    // webURL is the url for initializing Youtube on the browser.
    let webURL = NSURL(string: "https://www.youtube.com/channel/\(youtubeChannelId)")!
    let application = UIApplication.shared
    // Check if the Youtube app can be opened first. This means the user has it installed already.
    if application.canOpenURL(appURL as URL) {
        application.open(appURL as URL)
    } else {
        // if Youtube app is not installed, open URL inside Safari
        application.open(webURL as URL)
    }
    
}

// This function will take the user to a Twitter account given the handle represented by a String
func goToTwitterAccount(twitterUserID:String) {
    // appURL is the url for the Twitter app in particular
    let appURL = NSURL(string: "twitter://user?screen_name=\(twitterUserID)")!
    // webURL is the url for the browser variant of Twitter
    let webURL = NSURL(string: "https://twitter.com/\(twitterUserID)")!
    
    let application = UIApplication.shared
    
    // Try to open the Twitter app first if it is installed, otherwise if that fails, open the Twitter account on browser.
    if application.canOpenURL(appURL as URL) {
        application.open(appURL as URL)
    } else {
        application.open(webURL as URL)
    }
}

// This function will simplt redirect the user to the Google Spreadsheet for WNHL Fantasy in browser.
func goToFantasySpreadsheet(){
    let webURL = NSURL(string:  "https://docs.google.com/spreadsheets/d/e/2PACX-1vQ8bY-Of5YbJHk0VTj0LxWyQLYkK2dzWea-2fjd899X3qWMXGysbmE2UhqCdsFBLtJ233WjsGA_IMYJ/pubhtml?gid=0&single=true")!
    let application = UIApplication.shared
    application.open(webURL as URL)
}
