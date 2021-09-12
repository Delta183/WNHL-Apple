//
//  SecondSingleTeamSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit
import SQLite

class SecondSingleTeamSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet var singleTeamCollectionView: UICollectionView!
    @IBOutlet var headerCollectionView: UICollectionView!
    let reuseIdentifier = "teamSpreadsheetCell"
    let reuseIdentifier2 = "headerCell"
    var fontSize:CGFloat!
    var headerItems = ["Player","P","G","A"]
    var teamId:Int64!

    // This is the team Id passed from the parent SingleTeamViewController
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
        if collectionView == singleTeamCollectionView{
            return self.data.count
        }
        else {
            return self.headerItems.count
        }    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let containerWidth = view.frame.size.width
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Player Column
        // 134
        if indexPath.row == 0 || ((indexPath.row) % 4) == 0 {
            cellWidth = containerWidth * 0.358
        }
        // P/G/A columns
        else{
            cellWidth = containerWidth * 0.213
        }
        return CGSize(width: cellWidth, height: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if screenSize.width < 414 {
            fontSize = 10
        }
        else{
            fontSize = 12
        }
        if collectionView == singleTeamCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TeamSpreadsheetCollectionViewCell2
            cell.dataLabel2.text = self.data[indexPath.row] // The row value is the same as the index of the desired text within the array.
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! headerSecondSingleTeam
            cell.headerLabel.text = self.headerItems[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
    }
    
    override func viewDidLoad() {
        do {
            let db = try Connection("\(self.path)/wnhl.sqlite3")
            
            for player in try db.prepare(players){
                if player[currTeam] == teamId {   //sub 1842 for teamID passed from button
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
        headerCollectionView?.delegate = self;
        headerCollectionView?.dataSource = self;
    }
}
