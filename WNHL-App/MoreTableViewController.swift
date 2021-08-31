//
//  MoreTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit

class MoreTableViewController: UITableViewController {
    
    @IBOutlet var MoreTableView: UITableView!
    
    var entries = ["PLAYERS", "STATISTICS","YOUTUBE", "WNHL FANTASY", "NOTIFICATION SETTINGS", "UPDATE"]
    var iconNames = ["person.fill", "waveform.path.ecg", "play.circle", "star.circle.fill", "bell.fill","clock.arrow.circlepath"]
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
        else if rowNumber == 4 {
            self.performSegue(withIdentifier: "notificationSegue", sender: self)
        }
        else if rowNumber == 5 {
            self.performSegue(withIdentifier: "updateSegue", sender: self)
        }
        else{
            print(rowNumber)
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
        cell.iconImage.tintColor = UIColor.white
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
}
