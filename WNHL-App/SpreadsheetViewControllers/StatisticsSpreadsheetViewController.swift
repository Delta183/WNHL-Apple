//
//  StatisticsSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

// This class will create and populate the spreadsheets for the Statistics View
class StatisticsSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var GoalsCollectionView: UICollectionView?
    @IBOutlet var AssistsCollectionView: UICollectionView?
    @IBOutlet var PointsCollectionView: UICollectionView?
    var reuseIdentifier1 = "goalsCell"
    var reuseIdentifier2 = "assistsCell"
    var reuseIdentifier3 = "pointsCell"
    // The 3 arrays are for the Goals, Assists and Points spreadsheets respectively.
    var data1 = [
        "1", "Pat Riley", "Merritt Islanders", "12",
        "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
        "3", "Cockell", "Lincoln Street Legends", "8",
        "4", "Eric Sinclair", "Atlas Steelers", "7",
        "5", "Bryan Baz", "Dain City Dusters", "7",
        "6", "Ryan Daniels", "Merritt Islanders", "7",
        "7", "Chris Woods", "Townline Tunnelers", "7",
        "8", "Sean Boychuck", "Merritt Islanders", "6",
        "9", "Grant Vash", "Townline Tunnelers", "6",
        "10", "Bryan Baz", "Atlas Steelers", "6",
        "1", "Pat Riley", "Merritt Islanders", "12",
        "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
        "3", "Cockell", "Lincoln Street Legends", "8",
        "4", "Eric Sinclair", "Atlas Steelers", "7",
        "5", "Bryan Baz", "Dain City Dusters", "7",
        "6", "Ryan Daniels", "Merritt Islanders", "7",
        "7", "Chris Woods", "Townline Tunnelers", "7",
        "8", "Sean Boychuck", "Merritt Islanders", "6",
        "9", "Grant Vash", "Townline Tunnelers", "6",
        "10", "Bryan Baz", "Atlas Steelers", "6",
        "1", "Pat Riley", "Merritt Islanders", "12",
        "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
        "3", "Cockell", "Lincoln Street Legends", "8",
        "4", "Eric Sinclair", "Atlas Steelers", "7",
        "5", "Bryan Baz", "Dain City Dusters", "7",
        "6", "Ryan Daniels", "Merritt Islanders", "7",
        "7", "Chris Woods", "Townline Tunnelers", "7",
        "8", "Sean Boychuck", "Merritt Islanders", "6",
        "9", "Grant Vash", "Townline Tunnelers", "6",
        "10", "Bryan Baz", "Atlas Steelers", "6",
        "1", "Pat Riley", "Merritt Islanders", "12",
        "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
        "3", "Cockell", "Lincoln Street Legends", "8",
        "4", "Eric Sinclair", "Atlas Steelers", "7",
        "5", "Bryan Baz", "Dain City Dusters", "7",
        "6", "Ryan Daniels", "Merritt Islanders", "7",
        "7", "Chris Woods", "Townline Tunnelers", "7",
        "8", "Sean Boychuck", "Merritt Islanders", "6",
        "9", "Grant Vash", "Townline Tunnelers", "6",
        "10", "Bryan Baz", "Atlas Steelers", "6",
        "1", "Pat Riley", "Merritt Islanders", "12",
        "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
        "3", "Cockell", "Lincoln Street Legends", "8",
        "4", "Eric Sinclair", "Atlas Steelers", "7",
        "5", "Bryan Baz", "Dain City Dusters", "7",
        "6", "Ryan Daniels", "Merritt Islanders", "7",
        "7", "Chris Woods", "Townline Tunnelers", "7",
        "8", "Sean Boychuck", "Merritt Islanders", "6",
        "9", "Grant Vash", "Townline Tunnelers", "6",
        "10", "Bryan Baz", "Atlas Steelers", "6",
        "1", "Pat Riley", "Merritt Islanders", "12",
        "2", "Cory Hutchinson", "Lincoln Street Legends", "10",
        "3", "Cockell", "Lincoln Street Legends", "8",
        "4", "Eric Sinclair", "Atlas Steelers", "7",
        "5", "Bryan Baz", "Dain City Dusters", "7",
        "6", "Ryan Daniels", "Merritt Islanders", "7",
        "7", "Chris Woods", "Townline Tunnelers", "7",
        "8", "Sean Boychuck", "Merritt Islanders", "6",
        "9", "Grant Vash", "Townline Tunnelers", "6",
        "10", "Bryan Baz", "Atlas Steelers", "6",
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
    var data2 = [
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
    var data3 = [
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        // Max width of this component is 374
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
            return cell
        }
        else if collectionView == self.AssistsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! AssistsCollectionViewCell
            cell.dataLabel2.text = self.data2[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! PointsCollectionViewCell
            cell.dataLabel3.text = self.data3[indexPath.row]
            return cell
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
    }
}
