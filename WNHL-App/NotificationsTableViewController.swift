//
//  NotificationsTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class NotificationsTableViewController: UITableViewController {
    let defaults = UserDefaults.standard
    @IBOutlet var NotificationsTableView: UITableView!
    var reuseIdentifier = "notificationTableCell"
    var teams = ["Atlas Steelers", "Townline Tunnelers", "Crown Room Kings", "Dain City Dusters", "Lincoln Street Legends","Merritt Islanders"]
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
        let indexPath = NotificationsTableView.indexPathForSelectedRow
        let cell = NotificationsTableView.cellForRow(at: indexPath!) as! NotificationTableViewCell
        let rowNumber:String = String(indexPath!.row)
        if cell.checkButton.isSelected == false{
            cell.checkButton.isSelected = true
            defaults.setValue(true, forKey: "checkButton" + rowNumber)
        }
        else{
            cell.checkButton.isSelected = false
            defaults.setValue(false, forKey: "checkButton" + rowNumber)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotificationsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationTableViewCell
        let rowNumber:String = String(indexPath.row)
        
        cell.noSelectionStyle()
        cell.checkButton.isSelected = defaults.bool(forKey: "checkButton" + rowNumber)
        cell.teamLabel.text = teams[indexPath.row]
        cell.teamLabel.textColor = UIColor.white
        cell.teamLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.checkButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        cell.checkButton.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
