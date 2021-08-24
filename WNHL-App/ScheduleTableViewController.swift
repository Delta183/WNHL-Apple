//
//  ScheduleTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    let cellReuseIdentifier = "scheduleCell"
    let cellSpacingHeight: CGFloat = 10
    @IBOutlet var ScheduleTableView: UITableView!
    var games: [String] = ["Thu Dec 31, 2020\n12:52 AM\nPelham - Duliban\n bababooey", "Thu Dec 31, 2020\n12:52 AM\nPelham - Duliban\n bababooey", "Thu Dec 31, 2020\n12:52 AM\nPelham - Duliban\n bababooey", "Thu Dec 31, 2020\n12:52 AM\nPelham - Duliban\n bababooey", "Thu Dec 31, 2020\n12:52 AM\nPelham - Duliban\n bababooey"]
    
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
           
        let cell = self.ScheduleTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
       // note that indexPath.section is used rather than indexPath.row
       cell.textLabel?.text = self.games[indexPath.section]

       // add border and color
        //cell.imageView?.image = UIImage(named: "WNHL_Logo.png")
       cell.backgroundColor = UIColor.white
       cell.layer.borderColor = UIColor.black.cgColor
       cell.layer.borderWidth = 1
       cell.layer.cornerRadius = 8
        cell.textLabel?.textAlignment = NSTextAlignment.center
       cell.clipsToBounds = true
        
       
       return cell
       }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ScheduleTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
