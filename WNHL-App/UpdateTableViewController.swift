//
//  UpdateTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class UpdateTableViewController: UITableViewController {
    
    @IBOutlet var UpdateTableView: UITableView!
    var reuseIdentifier = "updateTableCell"
    var categories = ["PLAYERS","GAME SCHEDULE","TEAMS","STANDINGS","EVERYTHING",]
    var iconNames = ["person.fill", "calendar", "play.circle", "chart.bar.xaxis", "square.and.arrow.down",]
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UpdateTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UpdateTableViewCell
        cell.noSelectionStyle()
        cell.updateLabel.text = categories[indexPath.row]
        cell.updateLabel.textColor = UIColor.white
        cell.updateLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.iconImage.image = UIImage(systemName: iconNames[indexPath.row])
        cell.iconImage.tintColor = UIColor.white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
