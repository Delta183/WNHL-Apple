//
//  StandingsDisplayViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-13.
//

import UIKit

class StandingsDisplayViewController: UIViewController {
    let screenSize: CGRect = UIScreen.main.bounds
    // Either call the db on this or get the count of dataArrays
    var titles:[String] = []
    var dataArrays = [[String]]()

    var data = [
        "1", "Atlas Steelers", "28", "18", "7", "3", "39", "166", "97",
        "2", "Townline Tunnelers", "28", "18", "7", "3", "39", "159", "126",
        "3", "Crown Room Kings", "28", "10", "13", "5", "25", "121", "141",
        "4", "Welland Stelcobras", "28", "3", "22", "3", "9", "82", "164",
        "1", "Merritt Islanders", "11", "6", "2", "3", "15", "50", "35",
        "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
    ]
 

    @IBOutlet var standingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call the database functions to populate these here
        dataArrays = [data]
        titles = ["2020-2021"]
    }
}

extension StandingsDisplayViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StandingsSpreadsheetViewController = standingTableView.dequeueReusableCell(withIdentifier: "standingsCell", for: indexPath) as! StandingsSpreadsheetViewController
        // spreadsheetData is the 2d array that each array will populate a spreadsheet
        cell.spreadsheetData = dataArrays[indexPath.row]
        // This array will set the label above each spreadsheet given an array
        cell.titleLabel.text = titles[indexPath.row]
        cell.noSelectionStyle()
        cell.reloadCollectionView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numOfRows = (dataArrays[indexPath.row].count / 9)
        var height = numOfRows * 22
        if screenSize.height < 700{
            if numOfRows > 14 {
                height = 308
            }
        }
        else if screenSize.height < 850 {
            if numOfRows > 19 {
                height = 418
            }
        }
        else{
            if numOfRows > 22 {
                height = 474
            }
        }
        return CGFloat(height + 53)
    }
}
