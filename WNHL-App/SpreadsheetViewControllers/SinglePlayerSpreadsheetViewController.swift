//
//  SinglePlayerSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-31.
//

import UIKit

class SinglePlayerSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet var SinglePlayerSpreadsheetCollectionView: UICollectionView!
    @IBOutlet var headerCollectionView: UICollectionView!
    let reuseIdentifier =  "playerSpreadCell"
    let headerIdentifier = "headerCell"
    var fontSize:CGFloat = 12
    var backgroundColor:UIColor = UIColor.systemOrange
    var headerItems = ["Season", "Team", "P","G","A","S%","SV%","GP"]
    var positions = [
        "2030-2031", "Merritt Islanders", "11", "61", "21", "32", "15", "50",
        "2021-2022", "Townline Tunnelers", "11", "5", "2", "4", "14", "30",
        "2022-2023", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33",
        "2023-2024", "Atlas Steelers", "11", "4", "4", "3", "11", "37",
        "2024-2025", "Dain City Dusters", "11", "3", "6", "2", "8", "23",
        "2025-2026", "Crown Room Kings", "11", "1", "6", "4", "6", "22", ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.SinglePlayerSpreadsheetCollectionView{
            return self.positions.count
        }
        else{
            return self.headerItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let containerWidth = view.frame.size.width
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Season Title = 73
        if indexPath.row == 0 || ((indexPath.row ) % 8) == 0 {
            cellWidth = containerWidth * 0.195
        }
        // Team title = 133
        else if indexPath.row == 1 || ((indexPath.row - 1) % 8) == 0 {
            cellWidth = containerWidth * 0.355
        }
        // 1 letter title (P,G,A) = 28
        // 2-3 letter title (S%, SV%, GP) = 28
        else{
            cellWidth = containerWidth * 0.0748
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if screenSize.width <= 375 {
            fontSize = 10
            backgroundColor = UIColor.white
        }
        else if screenSize.width < 414{
            fontSize = 10
        }
        SinglePlayerSpreadsheetCollectionView.backgroundColor = backgroundColor

        if collectionView == self.SinglePlayerSpreadsheetCollectionView{

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SinglePlayerSpreadsheetCollectionViewCell
            cell.dataLabel.text = self.positions[indexPath.row]
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
        super.viewDidLoad()
        SinglePlayerSpreadsheetCollectionView?.delegate = self;
        SinglePlayerSpreadsheetCollectionView?.dataSource = self;
        headerCollectionView?.delegate = self;
        headerCollectionView?.dataSource = self;
    }
}
