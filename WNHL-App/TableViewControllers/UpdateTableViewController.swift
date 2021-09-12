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
    let cellSpacingHeight: CGFloat = 10

    
    func createSpinnerView(){
        let child = SpinnerViewController()
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
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
            // DO WORK HERE
            //ALERT DIALOG
            createSpinnerView()
            break
        // Game Schedule
        case 1:
            // DO WORK HERE
            //ALERT DIALOG

            
            
            break
        // Teams
        case 2:
            // DO WORK HERE
            //ALERT DIALOG
            
            
            break
        // Standings
        case 3:
            // DO WORK HERE
            //ALERT DIALOG
            
            
            break
        // Everything
        default:
            // DO WORK HERE
            //ALERT DIALOG
            
            
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
        cell.iconImage.tintColor = UIColor.white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
