//
//  SinglePlayerSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-31.
//

import UIKit

class SinglePlayerSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet var SinglePlayerSpreadsheetCollectionView: UICollectionView!
    let reuseIdentifier =  "playerSpreadCell"
    var positions = [
        "2030-2031", "Merritt Islanders", "11", "61", "21", "32", "15", "50",
        "2021-2022", "Townline Tunnelers", "11", "5", "2", "4", "14", "30",
        "2022-2023", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33",
        "2023-2024", "Atlas Steelers", "11", "4", "4", "3", "11", "37",
        "2024-2025", "Dain City Dusters", "11", "3", "6", "2", "8", "23",
        "2025-2026", "Crown Room Kings", "11", "1", "6", "4", "6", "22", ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.positions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Season Title
        if indexPath.row == 0 || ((indexPath.row ) % 8) == 0 {
            cellWidth = 73
        }
        // Team title
        else if indexPath.row == 1 || ((indexPath.row - 1) % 8) == 0 {
            cellWidth = 133
        }
        // 1 letter title (P,G,A)
        else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || ((indexPath.row - 2) % 8) == 0 || ((indexPath.row - 3) % 8) == 0 || ((indexPath.row - 4) % 8) == 0{
            cellWidth = 28
        }
        // 2-3 letter title (S%, SV%, GP)
        else{
            cellWidth = 28
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = SinglePlayerSpreadsheetCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SinglePlayerSpreadsheetCollectionViewCell
            cell.dataLabel.text = self.positions[indexPath.row]
            return cell
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SinglePlayerSpreadsheetCollectionView?.delegate = self;
        SinglePlayerSpreadsheetCollectionView?.dataSource = self;
    }
}
