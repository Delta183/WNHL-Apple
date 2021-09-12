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
    let youtubeChannelID:String = "UCklG51DEXWN6RodvW8Mj3cg"
    let twitterUserID:String = "WNHL2"
    
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
        // Players button
        switch rowNumber {
        case 0:
            self.performSegue(withIdentifier: "playersSegue", sender: self)
            break
        // Statistics button
        case 1:
            self.performSegue(withIdentifier: "statisticsSegue", sender: self)
            break
        // Youtube button
        case 2:
            // This string represents the id part of the Youtube URL for channels
            goToYoutubeChannel(youtubeChannelId: youtubeChannelID)
            break
        // Twitter button
        case 3:
            // This is a string representing the handle of the channel.
            goToTwitterAccount(twitterUserID: twitterUserID)
            break
        // WNHL Fantasy button
        case 4:
            goToFantasySpreadsheet()
            break
        // Notifications Settings button
        case 5:
            self.performSegue(withIdentifier: "notificationSegue", sender: self)
            break
        // Otherwise the last button by default is the Update button
        default:
            self.performSegue(withIdentifier: "updateSegue", sender: self)
            break
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
