//
//  SecondSingleTeamSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit
import SQLite

class SecondSingleTeamSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet var singleTeamCollectionView: UICollectionView!
    let reuseIdentifier = "teamSpreadsheetCell"
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let seasonID = Expression<String>("seasonID")
    let goals = Expression<Int64>("goals")
    let assists = Expression<Int64>("assists")
    let points = Expression<Int64>("points")
    let currTeam = Expression<Int64>("currTeam")
    let players = Table("Players")
    
    var data: [String] = []
        
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
        do {
            let db = try Connection("\(self.path)/wnhl.sqlite3")
            
            for player in try db.prepare(players){
                if player[currTeam] == 1824 {   //sub 1842 for teamID passed from button
                    data.append(player[name])
                    data.append(String(player[points]))
                    data.append(String(player[goals]))
                    data.append(String(player[assists]))
                }
            }
        }
        catch {
            print(error)
        }
        super.viewDidLoad()
        singleTeamCollectionView?.delegate = self;
        singleTeamCollectionView?.dataSource = self;
    }
}
