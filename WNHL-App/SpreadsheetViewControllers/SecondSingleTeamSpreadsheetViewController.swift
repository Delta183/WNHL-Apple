//
//  SecondSingleTeamSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit

class SecondSingleTeamSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet var singleTeamCollectionView: UICollectionView!
    var teamId:Int64!
    let reuseIdentifier = "teamSpreadsheetCell"
    var data = [
        "Podio", "3", "0", "3",
        "Jon Campbell", "3", "0", "3",
        "Scotty Mac", "3", "0", "3",
        "Mark Doyle", "3", "0", "3",
        "Matt Dusso", "3", "0", "3",
        "Eric Sinclair", "3", "0", "3",
        "Curt Rousseau", "3", "0", "3",
        "Justin Pupo", "3", "0", "3",
        "Chris Paco", "3", "0", "3",
        "Sawyer Smells", "3", "0", "3",
        "Very Good", "3", "0", "3",
        "Nah Just Kidding", "3", "0", "3",]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Player Column
        if indexPath.row == 0 || ((indexPath.row) % 4) == 0 {
            cellWidth = 134
        }
        // P/G/A columns
        else{
            cellWidth = 80
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TeamSpreadsheetCollectionViewCell2
        cell.dataLabel2.text = self.data[indexPath.row] // The row value is the same as the index of the desired text within the array.
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleTeamCollectionView?.delegate = self;
        singleTeamCollectionView?.dataSource = self;
       
    }
}
