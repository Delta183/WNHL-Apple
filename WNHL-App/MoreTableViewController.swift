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
        //print(rowNumber)
        if rowNumber == 0 {
            self.performSegue(withIdentifier: "playersSegue", sender: self)
        }
        else if rowNumber == 1 {
            self.performSegue(withIdentifier: "statisticsSegue", sender: self)
        }
        else if rowNumber == 2 {
            print(rowNumber)
            // Go to Youtube
        }
        else if rowNumber == 3 {
            print(rowNumber)
            // Go to twitter
        }
        else if rowNumber == 4 {
            print(rowNumber)
            // Go to WNHL Fantasy
        }
        else if rowNumber == 5 {
            self.performSegue(withIdentifier: "notificationSegue", sender: self)
        }
        else{
            self.performSegue(withIdentifier: "updateSegue", sender: self)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoreTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MoreTableViewCell
        cell.noSelectionStyle()
        cell.moreTextLabel.text = entries[indexPath.row]
        cell.moreTextLabel.textColor = UIColor.white
        cell.moreTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        cell.chevronImage.image = UIImage(systemName: "chevron.right")
        cell.chevronImage.tintColor = UIColor.white
        
        cell.iconImage.image = UIImage(systemName: iconNames[indexPath.row])
        if cell.iconImage.image == nil {
            if iconNames[indexPath.row] == "youtube_logo"{
                cell.iconImage.image = UIImage(named: "youtube_logo")
            }
            else{
                cell.iconImage.image = UIImage(named: "twitter_logo")
            }
        }
        cell.iconImage.tintColor = UIColor.white
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
}
