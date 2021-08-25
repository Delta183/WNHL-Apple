//
//  ScheduleTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    let cellReuseIdentifier = "scheduleCell"
    let cellSpacingHeight: CGFloat = 20
    @IBOutlet var ScheduleTableView: UITableView!
    var games: [String] = ["Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers", "Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers","Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers","Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers","Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers",]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
           return self.games.count
       }
       
       // There is just one row in every section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        
        let cell = self.ScheduleTableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        cell.scheduleText.numberOfLines = 0
        cell.scheduleText.font = UIFont.systemFont(ofSize: 16)
       // note that indexPath.section is used rather than indexPath.row
       cell.scheduleText.text = self.games[indexPath.section]
        cell.scheduleText.textAlignment = NSTextAlignment.center
        cell.HomeImage.image = UIImage(named: "WNHL_Logo.png")
        cell.AwayImage.image = UIImage(named: "WNHL_Logo.png")

       // add border and color
       cell.backgroundColor = UIColor.white
       cell.layer.borderWidth = 0
       cell.layer.cornerRadius = 24
       cell.clipsToBounds = true
        
       
       return cell
       }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ScheduleTableView.delegate = self
        ScheduleTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
