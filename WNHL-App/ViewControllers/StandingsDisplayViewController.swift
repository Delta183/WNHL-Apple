//
//  StandingsDisplayViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-13.
//

import UIKit

class StandingsDisplayViewController: UIViewController {
    // Either call the db on this or get the count of dataArrays
    var titles:[String] = []
    var dataArrays = [[String]]()
    var data: [String] = []
    var teams: [Int64] = []
    var data1 = [
        "1", "Welland Undertakers", "30", "14", "9", "7", "35", "189", "161",
        "2", "Welland River Rats", "30", "9", "17", "4", "22", "143", "179",
    ]

    var data2 = [
        "1", "Atlas Steelers", "6", "6", "0", "0", "12", "38", "11",
        "2", "Townline Tunnelers", "6", "4", "2", "0", "8", "21", "20",
        "3", "Lincoln Street Legends", "6", "1", "5", "0", "2", "12", "25",
        "4", "Crown Room Kings", "6", "1", "5", "0", "2", "14", "29",
    ]
    var data3 = [
        "1", "Merritt Islanders", "11", "6", "2", "3", "15", "50", "35",
        "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
        "3", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33", "34",
        "4", "Atlas Steelers", "11", "4", "4", "3", "11", "37", "37",
        "5", "Dain City Dusters", "11", "3", "6", "2", "8", "23", "33",
        "6", "Crown Room Kings", "11", "1", "6", "4", "6", "22", "30",
    ]
    var data4 = [
        "1", "Welland Undertakers", "6", "3", "2", "1", "7", "24", "21",
        "2", "Welland River Rats", "6", "2", "3", "1", "5", "23", "26",
    ]
    var data5 = [
        "1", "Welland Undertakers", "30", "14", "9", "7", "35", "189", "161",
        "2", "Welland River Rats", "30", "9", "17", "4", "22", "143", "179",
    ]

    @IBOutlet var standingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArrays.append(getStandingsInOrder())
        // Call the database functions to populate these here
        titles = ["2020-2021"]
    }
}

extension StandingsDisplayViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrays.count
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
        if numOfRows >= 6{
            height = (132)
        }
        return CGFloat(height + 65)
    }
}
