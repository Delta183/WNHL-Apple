//
//  SpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-11.
//

import UIKit

class StandingsSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    let screenSize: CGRect = UIScreen.main.bounds
    // Outlets for all the collection views on the Standings View
    @IBOutlet var CollectionView1: UICollectionView?
    @IBOutlet var CollectionView2: UICollectionView?
    @IBOutlet var CollectionView3: UICollectionView?
    @IBOutlet var CollectionView4: UICollectionView?
    @IBOutlet var CollectionView5: UICollectionView?
    @IBOutlet var headerCollectionView1: UICollectionView!
    @IBOutlet var headerCollectionView2: UICollectionView!
    @IBOutlet var headerCollectionView3: UICollectionView!
    @IBOutlet var headerCollectionView4: UICollectionView!
    @IBOutlet var headerCollectionView5: UICollectionView!
    // reuseIdentifiers for the respective cells of the collection views such that they can be referenced here
    let reuseIdentifier1 = "cell"
    let reuseIdentifier2 = "cell2"
    let reuseIdentifier3 = "cell3"
    let reuseIdentifier4 = "cell4"
    let reuseIdentifier5 = "cell5"
    let reuseIdentifier6 = "headerCell"
    var fontSize:CGFloat!
    var headerItems = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA"]

    
    // The arrays housing the data for each respective collection view
    var positions = [
        "1", "Merritt Islanders", "11", "6", "2", "3", "15", "50", "35",
        "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
        "3", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33", "34",
        "4", "Atlas Steelers", "11", "4", "4", "3", "11", "37", "37",
        "5", "Dain City Dusters", "11", "3", "6", "2", "8", "23", "33",
        "6", "Crown Room Kings", "11", "1", "6", "4", "6", "22", "30",
        "1", "Merritt Islanders", "11", "6", "2", "3", "15", "50", "35",
        "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
        "3", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33", "34",
        "4", "Atlas Steelers", "11", "4", "4", "3", "11", "37", "37",
        "5", "Dain City Dusters", "11", "3", "6", "2", "8", "23", "33",
        "6", "Crown Room Kings", "11", "1", "6", "4", "6", "22", "30",]
    var positions2 = [
        "1", "Atlas Steelers", "6", "6", "0", "0", "12", "38", "11",
        "2", "Townline Tunnelers", "6", "4", "2", "0", "8", "21", "20",
        "3", "Lincoln Street Legends", "6", "1", "5", "0", "2", "12", "25",
        "4", "Crown Room Kings", "6", "1", "5", "0", "2", "14", "29",
    ]
    var positions3 = [
        "1", "Atlas Steelers", "28", "18", "7", "3", "39", "166", "97",
        "2", "Townline Tunnelers", "28", "18", "7", "3", "39", "159", "126",
        "3", "Crown Room Kings", "28", "10", "13", "5", "25", "121", "141",
        "4", "Welland Stelcobras", "28", "3", "22", "3", "9", "82", "164",
        "1", "Merritt Islanders", "11", "6", "2", "3", "15", "50", "35",
        "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
        "3", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33", "34",
        "4", "Atlas Steelers", "11", "4", "4", "3", "11", "37", "37",
        "5", "Dain City Dusters", "11", "3", "6", "2", "8", "23", "33",
        "6", "Crown Room Kings", "11", "1", "6", "4", "6", "22", "30",
    ]
    var positions4 = [
        "1", "Welland Undertakers", "6", "3", "2", "1", "7", "24", "21",
        "2", "Welland River Rats", "6", "2", "3", "1", "5", "23", "26",
    ]
    var positions5 = [
        "1", "Welland Undertakers", "30", "14", "9", "7", "35", "189", "161",
        "2", "Welland River Rats", "30", "9", "17", "4", "22", "143", "179",
    ]
    
    // MARK: - UICollectionViewDataSource protocol
    
    // Set the number of items in the sole section, in other words, tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Only make as many cells that the amount of the specific array for each collection view.
        // This is because not all the spreadsheets will have the same amount of data
        if collectionView == CollectionView1 {
            return self.positions.count
        }
        else if collectionView == CollectionView2{
            return self.positions2.count
        }
        else if collectionView == CollectionView3{
            return self.positions3.count
        }
        else if collectionView == CollectionView4 {
            return self.positions4.count
        }
        else if collectionView == CollectionView5 {
            return self.positions5.count
        }
        else{
            return self.headerItems.count
        }
    }
    
    
    // This function will set the layout the cells for the 5 spreadsheets of this class
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let containerWidth = view.frame.size.width
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Team title
        if indexPath.row == 1 || ((indexPath.row - 1) % 9) == 0 {
            // 145
            cellWidth = containerWidth * 0.387
        }
        // 1 Letter titles (W,L,T)
        else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ||
                    ((indexPath.row - 3) % 9) == 0 || ((indexPath.row - 4) % 9) == 0 || ((indexPath.row - 5) % 9) == 0{
            // 23
            cellWidth = containerWidth * 0.0625
        }
        // 2 letter titles (GP, GF, GA)
        // 3 letter title (PTS, Pos)
        else{
            // 32
            cellWidth = containerWidth * 0.085
        }
        // Set the size of the cell to be of the determined width though all cells will have the exact same height of 24.
        return CGSize(width: cellWidth, height: 24)
    }
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if screenSize.width < 414 {
            fontSize = 10
        }
        else{
            fontSize = 12
        }
        if collectionView == self.CollectionView1 {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell1
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.posLabel.text = self.positions[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell.posLabel.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else if collectionView == self.CollectionView2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell2
            cell.posLabel2.text = self.positions2[indexPath.row]
            cell.posLabel2.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else if collectionView == self.CollectionView3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell3
            cell.posLabel3.text = self.positions3[indexPath.row]
            cell.posLabel3.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else if collectionView == self.CollectionView4{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier4, for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell4
            cell.posLabel4.text = self.positions4[indexPath.row]
            cell.posLabel4.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else if collectionView == self.CollectionView5{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier5, for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell5
            cell.posLabel5.text = self.positions5[indexPath.row]
            cell.posLabel5.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier6, for: indexPath as IndexPath) as! headerStandings
            cell.headerLabel.text = self.headerItems[indexPath.row]
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
    }
    // MARK: - UICollectionViewDelegate protocol
    override func viewDidLoad() {
        CollectionView1?.delegate = self;
        CollectionView1?.dataSource = self;
        CollectionView2?.delegate = self;
        CollectionView2?.dataSource = self;
        CollectionView3?.delegate = self;
        CollectionView3?.dataSource = self;
        CollectionView4?.delegate = self;
        CollectionView4?.dataSource = self;
        CollectionView5?.delegate = self;
        CollectionView5?.dataSource = self;
        headerCollectionView1?.delegate = self;
        headerCollectionView1?.dataSource = self;
        headerCollectionView2?.delegate = self;
        headerCollectionView2?.dataSource = self;
        headerCollectionView3?.delegate = self;
        headerCollectionView3?.dataSource = self;
        headerCollectionView4?.delegate = self;
        headerCollectionView4?.dataSource = self;
        headerCollectionView5?.delegate = self;
        headerCollectionView5?.dataSource = self;
        super.viewDidLoad()
    }
    
}
