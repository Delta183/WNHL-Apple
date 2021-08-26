//
//  ScheduleTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit

// View Controllers represent each screen, A basic screen is known as a View Controller but a view entirely devoted to say a TableView is a TableViewController. Thus this class is responsible for affecting strictly the table on the Schedule screen.
class ScheduleTableViewController: UITableViewController {

    // The cells are part of a table or collection. In this case it is of a table which is composed of multiple rows and populates downwards much like in the More and Teams page. Much like variables, they must have some identifier or name that is unique.
    let cellReuseIdentifier = "scheduleCell"
    // This is responsible for the height of the spacing between each row in pixels
    let cellSpacingHeight: CGFloat = 20
    @IBOutlet var ScheduleTableView: UITableView!
    // The value that dynamically builds the table is derived from the array here, if you can fetch data from the database and populate it here with the same formatting, then that will accomplish the data population as the rest of the UI formatting lies below.
    var games: [String] = ["Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers", "Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers","Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers","Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers","Wed. Oct 7, 2020\n2 - 2\nNiagara Falls - Gale Center\nCrown Room Kings vs Townline Tunnelers",]
    
    // These are functions that act like attributes for the Table View. This responsible for the number of sections, for our purposes, all we need is 1
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
        
        // ScheduleTableViewCell is custom made by myself that has 2 image views one text label, highlighting and right clicking the ScheduleTableViewCell and jumping to Definition should display the outlets that the Custom cell class contains.
        // Think classes in Java, housing a bunch of elements repeatedly used in a singular class.
        let cell = self.ScheduleTableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        // Once the cell is fetched, modify it as needed
        // The imageViews and text labels were given unique identifiers being HomeImage and AwayImage for the images and scheduleText for the text label.
        cell.scheduleText.numberOfLines = 0
        cell.scheduleText.font = UIFont.systemFont(ofSize: 16)
        // The text label is populated with whatever data is at this index in the games array at the top of the file.
        // indexPath.row seems to start from 0 to n.
       cell.scheduleText.text = self.games[indexPath.row]
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
