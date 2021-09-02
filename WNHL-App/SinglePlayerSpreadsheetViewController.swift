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
    
    // 374
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var cellWidth:CGFloat = CGFloat()
        if indexPath.row == 0 || ((indexPath.row ) % 8) == 0 {
            cellWidth = 73
        }
        // Team title
        else if indexPath.row == 1 || ((indexPath.row - 1) % 8) == 0 {
            cellWidth = 133
        }
        // 2 letter title
        else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || ((indexPath.row - 2) % 8) == 0 || ((indexPath.row - 3) % 8) == 0 || ((indexPath.row - 4) % 8) == 0{
            cellWidth = 28
        }
        // 3 letter title
        else{
            cellWidth = 28
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            // get a reference to our storyboard cell
            let cell = SinglePlayerSpreadsheetCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SinglePlayerSpreadsheetCollectionViewCell
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.dataLabel.text = self.positions[indexPath.row] // The row value is the same as the index of the desired text within the array.
            return cell
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SinglePlayerSpreadsheetCollectionView?.delegate = self;
        SinglePlayerSpreadsheetCollectionView?.dataSource = self;


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
