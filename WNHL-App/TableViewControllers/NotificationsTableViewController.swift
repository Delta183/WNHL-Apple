//
//  NotificationsTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

protocol ChildToParentProtocol:AnyObject {
    
        func needToPassInfoToParent(with isNowChecked:Bool, teamNameString:String)
    
}
// Make button click also toggle
class NotificationsTableViewController: UITableViewController {
    
    weak var delegate:ChildToParentProtocol? = nil
    // Defaults are effectively the local storage of the app such that data can persist
    let defaults = UserDefaults.standard
    @IBOutlet var NotificationsTableView: UITableView!
    var reuseIdentifier = "notificationTableCell"
    var teams:[String] = []
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teams.count
    }
    
    // When a button is selected on this table, the button will be toggled as opposed to taking the user to another view via segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = NotificationsTableView.indexPathForSelectedRow
        // Get the cell at the particular row index
        let cell = NotificationsTableView.cellForRow(at: indexPath!) as! NotificationTableViewCell
        // Track the number of the the button selected such that it can be used as the unique key
        let rowNumber:String = String(indexPath!.row)
        // Archive the name of the team into a string for the toast message
        let teamNameString:String = cell.teamLabel.text!
        // Check if the button has been toggled and toggle if it is not. Vice versa if it is not toggled.
        if cell.checkButton.isSelected == false{
            cell.checkButton.isSelected = true
            // Set the state of the button to be preserved in the defaults given a unique key.
            defaults.setValue(true, forKey: "checkButton" + rowNumber)
            delegate?.needToPassInfoToParent(with: true, teamNameString: teamNameString)
        }
        else{
            cell.checkButton.isSelected = false
            defaults.setValue(false, forKey: "checkButton" + rowNumber)
            delegate?.needToPassInfoToParent(with: false, teamNameString: teamNameString)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotificationsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationTableViewCell
        let rowNumber:String = String(indexPath.row)
        
        cell.noSelectionStyle()
        cell.checkButton.isSelected = defaults.bool(forKey: "checkButton" + rowNumber)
        var teamString = teams[indexPath.row]
        teamString = teamString.replacingOccurrences(of: "-", with: " ")
        cell.teamLabel.text = teamString.uppercased()
        cell.teamLabel.textColor = UIColor.white
        cell.teamLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.checkButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        cell.checkButton.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        // The same functionality at the didSelectRowAt yet for the actual checkbox button itself.
        cell.checkButton.mk_addTapHandler { (btn) in
            self.buttonClicked(cell: cell, rowNumberString: rowNumber)
        }
        
        // Add toast analog
        return cell
    }
    
    override func viewDidLoad() {
        // Similarly change this to call on the userDefaults
        teams = getTeamsFromSeasonId(seasonIdString: "34")
        super.viewDidLoad()
    }
    
    func buttonClicked(cell:NotificationTableViewCell, rowNumberString: String) {
        let teamNameString:String = cell.teamLabel.text!
        if cell.checkButton.isSelected == false{
            cell.checkButton.isSelected = true
            defaults.setValue(true, forKey: "checkButton" + rowNumberString)
            delegate?.needToPassInfoToParent(with: true, teamNameString: teamNameString)
        }
        else{
            cell.checkButton.isSelected = false
            defaults.setValue(false, forKey: "checkButton" + rowNumberString)
            delegate?.needToPassInfoToParent(with: false, teamNameString: teamNameString)
        }
        
    }
}



