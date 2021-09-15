//
//  UpdateTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit
import Network
import Alamofire

class UpdateTableViewController: UITableViewController {
    
    @IBOutlet var UpdateTableView: UITableView!
    var reuseIdentifier = "updateTableCell"
    var categories = ["PLAYERS","GAME SCHEDULE","TEAMS","STANDINGS","EVERYTHING",]
    var iconNames = ["person.fill", "calendar", "hockeyStickUpdate", "chart.bar.xaxis", "square.and.arrow.down",]
    let cellSpacingHeight: CGFloat = 10
    let service = Service(baseUrl: "http://www.wnhlwelland.ca/wp-json/sportspress/v2/")
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // This function monitors the selection of a row in the table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = UpdateTableView.indexPathForSelectedRow
        let rowNumber:Int = indexPath!.row as Int
        switch rowNumber {
        // Players
        case 0:
            //Alert Dialog
            parent?.showSpinner()
            service.updatePlayers(tableView: self)
            break
        // Game Schedule
        case 1:
            //Alert Dialog
            parent?.showSpinner()
            service.updateEvents(tableView: self)
            break
        // Teams
        case 2:
            //Alert Dialog
            parent?.showSpinner()
            service.updateTeams(tableView: self)
            break
        // Standings
        case 3:
            //Alert Dialog
            parent?.showSpinner()
            service.updateStandings(tableView: self)
            break
        // Everything
        default:
            //do nothing
            //Alert Dialog
            parent?.showSpinner()
            service.updateApp(tableView: self)
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UpdateTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UpdateTableViewCell
        cell.noSelectionStyle()
        cell.updateLabel.text = categories[indexPath.row]
        cell.updateLabel.textColor = UIColor.white
        cell.updateLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.iconImage.image = UIImage(systemName: iconNames[indexPath.row])
        if cell.iconImage.image == nil{
            cell.iconImage.image = UIImage(named: iconNames[indexPath.row])
        }
        cell.iconImage.tintColor = UIColor.white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
    }
    
    func monitorNetwork(){
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    //do nothing
                    print("connected")
                }
            }
            else {
                DispatchQueue.main.async {
                    self.showToast(message: "No Internet Connection. Try Again Later", font: .systemFont(ofSize: 12))
                    self.parent?.removeSpinner()
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}
