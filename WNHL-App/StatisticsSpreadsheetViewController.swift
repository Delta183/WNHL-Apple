//
//  StatisticsSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class StatisticsSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var GoalsCollectionView: UICollectionView?
    @IBOutlet var AssistsCollectionView: UICollectionView?
    @IBOutlet var PointsCollectionView: UICollectionView?
    var reuseIdentifier1 = "goalsCell"
    var reuseIdentifier2 = "assistsCell"
    var reuseIdentifier3 = "pointsCell"
    var data1 = ["Rank", "Player", "Team", "G",
                 "1", "Pat Riley", "Merritt Islanders", "12",
                 "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
                 "3", "Cockell", "Lincoln Street Legends", "8",
                 "4", "Eric Sinclair", "Atlas Steelers", "7",
                 "5", "Bryan Baz", "Dain City Dusters", "7",
                 "6", "Ryan Daniels", "Merritt Islanders", "7",
                 "7", "Chris Woods", "Townline Tunnelers", "7",
                 "8", "Sean Boychuck", "Merritt Islanders", "6",
                 "9", "Grant Vash", "Townline Tunnelers", "6",
                 "10", "Bryan Baz", "Atlas Steelers", "6",]
    var data2 = ["Rank", "Player", "Team", "G",
                 "1", "Pat Riley", "Merritt Islanders", "12",
                 "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
                 "3", "Cockell", "Lincoln Street Legends", "8",
                 "4", "Eric Sinclair", "Atlas Steelers", "7",
                 "5", "Bryan Baz", "Dain City Dusters", "7",
                 "6", "Ryan Daniels", "Merritt Islanders", "7",
                 "7", "Chris Woods", "Townline Tunnelers", "7",
                 "8", "Sean Boychuck", "Merritt Islanders", "6",
                 "9", "Grant Vash", "Townline Tunnelers", "6",
                 "10", "Bryan Baz", "Atlas Steelers", "6",]
    var data3 = ["Rank", "Player", "Team", "G",
                 "1", "Pat Riley", "Merritt Islanders", "12",
                 "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
                 "3", "Cockell", "Lincoln Street Legends", "8",
                 "4", "Eric Sinclair", "Atlas Steelers", "7",
                 "5", "Bryan Baz", "Dain City Dusters", "7",
                 "6", "Ryan Daniels", "Merritt Islanders", "7",
                 "7", "Chris Woods", "Townline Tunnelers", "7",
                 "8", "Sean Boychuck", "Merritt Islanders", "6",
                 "9", "Grant Vash", "Townline Tunnelers", "6",
                 "10", "Bryan Baz", "Atlas Steelers", "6",]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == GoalsCollectionView{
            return self.data1.count
        }
        else if collectionView == AssistsCollectionView{
            return self.data2.count
        }
        else{
            return self.data3.count
        }
    }
    
    // Max width is 374
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        var cellWidth:CGFloat = CGFloat()
        // Rank Column
        if indexPath.row == 0 || ((indexPath.row) % 4) == 0 {
            cellWidth = 45
           }
        // Player Column
        else if indexPath.row == 1 || ((indexPath.row - 1) % 4) == 0 {
            cellWidth = 140
           }
        // Team Column
        else if indexPath.row == 2 || ((indexPath.row - 2) % 4) == 0{
            cellWidth = 155
        }
        // 4th column
       else{
        cellWidth = 34
       }
           return CGSize(width: cellWidth, height: 24)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.GoalsCollectionView {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! GoalsCollectionViewCell
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.dataLabel1.text = self.data1[indexPath.row] // The row value is the same as the index of the desired text within the array.
            if indexPath.row < 4 {
                cell.dataLabel1.font  = UIFont.boldSystemFont(ofSize: 12.0)
            }
            //cell.layer.borderWidth = 1
            cell.backgroundColor = UIColor.white // make cell more visible in our example project
            return cell
        }
        else if collectionView == self.AssistsCollectionView{
            // get a reference to our storyboard cell
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! AssistsCollectionViewCell

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell2.dataLabel2.text = self.data2[indexPath.row] // The row value is the same as the index of the desired text within the array.
            if indexPath.row < 4 {
                cell2.dataLabel2.font  = UIFont.boldSystemFont(ofSize: 12.0)
            }
            cell2.backgroundColor = UIColor.white // make cell more visible in our example project
            return cell2
        }
        else{
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! PointsCollectionViewCell
            cell3.dataLabel3.text = self.data3[indexPath.row] // The row value is the same as the index of the desired text within the array.
            if indexPath.row < 4 {
                cell3.dataLabel3.font  = UIFont.boldSystemFont(ofSize: 12.0)
            }
            cell3.backgroundColor = UIColor.white // make cell more visible in our example project
            return cell3
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GoalsCollectionView?.delegate = self;
        GoalsCollectionView?.dataSource = self;
        AssistsCollectionView?.delegate = self;
        AssistsCollectionView?.dataSource = self;
        PointsCollectionView?.delegate = self;
        PointsCollectionView?.dataSource = self;
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
