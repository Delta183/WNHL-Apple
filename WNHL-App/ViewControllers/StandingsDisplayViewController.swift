//
//  StandingsDisplayViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-13.
//

import UIKit

class StandingsDisplayViewController: UIViewController {
    @IBOutlet var standingTableView: UITableView!
    let screenSize: CGRect = UIScreen.main.bounds
    // titles is the array responsible for the title of each spreadsheet on the screen.
    var titles:[String] = []
    // dataArrays will contain all the arrays for the Standings to populate the view.
    var dataArrays = [[String]]()
    var fontSize:CGFloat = 24
    // The "data" array is what will populate the cells in the spreadsheet.
    var data = [
        "1", "Atlas Steelers", "28", "18", "7", "3", "39", "166", "97",
        "2", "Townline Tunnelers", "28", "18", "7", "3", "39", "159", "126",
        "3", "Crown Room Kings", "28", "10", "13", "5", "25", "121", "141",
        "4", "Welland Stelcobras", "28", "3", "22", "3", "9", "82", "164",
        "1", "Merritt Islanders", "11", "6", "2", "3", "15", "50", "35",
        "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
    ]
 

    override func viewDidLoad() {
        // Call the database functions to populate these here
        dataArrays = [data]
        titles = ["2020-2021"]
        super.viewDidLoad()
    }
}

extension StandingsDisplayViewController:UITableViewDelegate, UITableViewDataSource {
    
    // Set the number of sections for the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // set the number of rows in each section of the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Build the cell at each index for the provided data in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Instantiate the cell to be that of the StandingsSpreadsheetViewController which is a TableViewCell object
        let cell:StandingsSpreadsheetViewController = standingTableView.dequeueReusableCell(withIdentifier: "standingsCell", for: indexPath) as! StandingsSpreadsheetViewController
        // spreadsheetData is the 2d array that each array will populate a spreadsheet
        cell.spreadsheetData = dataArrays[indexPath.row]
        // This array will set the label above each spreadsheet given an array
        cell.titleLabel.text = titles[indexPath.row]
        cell.titleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        // noSelectionStyle denotes that there will be no highlight when an object is clicked
        cell.noSelectionStyle()
        // this will reload the view when all the data is completely loaded in
        cell.reloadCollectionView()
        return cell
    }
    
    // Sets the height for each row of the table or otherwise a table cell.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numOfRows = (dataArrays[indexPath.row].count / 9)
        var height = numOfRows * 22
        // Given the various different heights of the iPhones, the upper threshold for the max amount of rows to populate a single screen is different
        // First check if the height denotes that of an 6,7,8 or below.
        if screenSize.height < 700{
            if numOfRows > 14 {
                height = 308
            }
        }
        // Otherwise check if the height denotes that of iPhone 12
        else if screenSize.height < 850 {
            if numOfRows > 19 {
                height = 418
            }
        }
        // Lastly, it would be and iPhone 11 or larger which means the most amount of rows can be shown on a screen.
        else{
            if numOfRows > 22 {
                height = 474
            }
        }
        // The 53 offset is to account for the header items and the title for the spreadsheet.
        return CGFloat(height + 53)
    }
}
