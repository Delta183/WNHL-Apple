//
//  SinglePlayerSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-31.
//

import UIKit

class SinglePlayerSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet var SinglePlayerSpreadsheetCollectionView: UICollectionView!
    @IBOutlet var headerCollectionView: UICollectionView!
    let reuseIdentifier =  "playerSpreadCell"
    let headerIdentifier = "headerCell"
    var fontSize:CGFloat = 12
    var iphoneOffsetSeasonTeam:CGFloat = 0.00
    var iphoneOffsetLabel:CGFloat = 0.00
    let screenSize: CGRect = UIScreen.main.bounds
    var backgroundColor:UIColor = UIColor.systemOrange
    // The strings that will go in each cell of the header collection view
    var headerItems = ["Season", "Team", "P","G","A","S%","SV%","GP"]
    // This array holds the data that will display on the spreadsheet
    // They will be entered in the same order as the header items
    var spreadsheetData = [
        "2020-2021", "Merritt Islanders", "11", "61", "21", "32", "15", "50",
        "2021-2022", "Townline Tunnelers", "11", "5", "2", "4", "14", "30",
        "2022-2023", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33",
        "2023-2024", "Atlas Steelers", "11", "4", "4", "3", "11", "37",
        "2024-2025", "Dain City Dusters", "11", "3", "6", "2", "8", "23",
        "2025-2026", "Crown Room Kings", "11", "1", "6", "4", "6", "22", ]
    
    // Set the number of items in the sole section, in other words, tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.SinglePlayerSpreadsheetCollectionView{
            return self.spreadsheetData.count
        }
        else{
            return self.headerItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // Calculate an offset for the iPhone 12 to ensure no clipping occurs for the orange background since the clipping issue only exists with that device
        if screenSize.width > 375 && screenSize.width < 414 {
            iphoneOffsetSeasonTeam = 0.0001
            iphoneOffsetLabel = 0.00016
        }
        let containerWidth = view.frame.size.width
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Season Title = 73
        if indexPath.row == 0 || ((indexPath.row ) % 8) == 0 {
            cellWidth = containerWidth * (0.195 + iphoneOffsetSeasonTeam)
        }
        // Team title = 133
        else if indexPath.row == 1 || ((indexPath.row - 1) % 8) == 0 {
            cellWidth = containerWidth * (0.355  + iphoneOffsetSeasonTeam)
        }
        // 1 letter title (P,G,A) = 28
        // 2-3 letter title (S%, SV%, GP) = 28
        else{
            // 0.0748 to 0.07496
            cellWidth = containerWidth * (0.0748 + iphoneOffsetLabel)
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    // make a cell for each cell at each index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Check if the width of the screen is less than that of the iPhone 12, adjust the font to be smaller such that the text will fit.
        if screenSize.width <= 375 {
            fontSize = 10
            backgroundColor = UIColor.white
        }
        // Check if the width of the screen is less than that of the iPhone 11, adjust the font to be smaller such that the text will fit though not to change the background color in this case
        // i.e. iPhone 12
        else if screenSize.width < 414{
            fontSize = 10
        }
        SinglePlayerSpreadsheetCollectionView.backgroundColor = backgroundColor

        // Check for the correct collection view prior to populating the cell.
        if collectionView == self.SinglePlayerSpreadsheetCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SinglePlayerSpreadsheetCollectionViewCell
            cell.dataLabel.text = self.spreadsheetData[indexPath.row]
            cell.dataLabel.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerIdentifier, for: indexPath as IndexPath) as! headerSinglePlayer
            cell.headerLabel.text = self.headerItems[indexPath.row]
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
    }
    
    override func viewDidLoad() {
        // Set the delegate and datasource of all collectionViews to be this class.
        SinglePlayerSpreadsheetCollectionView?.delegate = self;
        SinglePlayerSpreadsheetCollectionView?.dataSource = self;
        headerCollectionView?.delegate = self;
        headerCollectionView?.dataSource = self;
        super.viewDidLoad()
    }
}
