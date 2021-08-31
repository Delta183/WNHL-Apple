//
//  SingleTeamSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit

class FirstSingleTeamSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    let reuseIdentifier = "teamSpreadsheetCell"
    @IBOutlet var singleTeamCollectionView: UICollectionView!
    var data = ["1", "Merritt Islanders", " 11", "6", "2", "3", "15", "50", "35",]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        var cellWidth:CGFloat = CGFloat()
        // Team title
        if indexPath.row == 1 || ((indexPath.row - 1) % 9) == 0 {
            cellWidth = 145
        }
        // 2 letter title
        else if indexPath.row == 2 || indexPath.row == 7 || indexPath.row == 8 || ((indexPath.row - 2) % 9) == 0 || ((indexPath.row - 7) % 9) == 0 || ((indexPath.row - 8) % 9) == 0{
            cellWidth = 32
        }
        // 1 Letter titles
        else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ||
                    ((indexPath.row - 3) % 9) == 0 || ((indexPath.row - 4) % 9) == 0 || ((indexPath.row - 5) % 9) == 0{
            cellWidth = 23
        }
        // 3 letter title
        else{
            cellWidth = 32
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TeamSpreadsheetCollectionViewCell1
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.dataLabel1.text = self.data[indexPath.row] // The row value is the same as the index of the desired text within the array.
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleTeamCollectionView?.delegate = self;
        singleTeamCollectionView?.dataSource = self;
    }
}
