//
//  SingleTeamSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit
import SQLite

class FirstSingleTeamSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet var singleTeamCollectionView: UICollectionView!
    @IBOutlet var headerCollectionView: UICollectionView!
    let reuseIdentifier = "teamSpreadsheetCell"
    let reuseIdentifier2 = "headerCell"
    var teamId:Int64!
    var fontSize:CGFloat!
    var headerItems = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA"]
    var data = ["1", "Merritt Islanders", " 11", "6", "2", "3", "15", "50", "35",]
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    
    //var data: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == singleTeamCollectionView{
            return self.data.count
        }
        else {
            return self.headerItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let containerWidth = view.frame.size.width
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Team title
        if indexPath.row == 1 || ((indexPath.row - 1) % 9) == 0 {
            cellWidth = containerWidth * 0.387
        }
        // 1 Letter titles (W, L, T)
        else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ||
                    ((indexPath.row - 3) % 9) == 0 || ((indexPath.row - 4) % 9) == 0 || ((indexPath.row - 5) % 9) == 0{
            cellWidth = containerWidth * 0.0625
        }
        // 3 letter titles (Pos, PTS)
        // 2 letter titles (GP, GF, GA)
        else{
            cellWidth = containerWidth * 0.085
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TeamSpreadsheetCollectionViewCell1
            cell.dataLabel1.text = self.data[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! headerFirstSingleTeam
            cell.headerLabel.text = self.headerItems[indexPath.row]
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
       
    }
    
    override func viewDidLoad() {
        do {
//            let db = try Connection("\(self.path)/wnhl.sqlite3")
//
//            for player in try db.prepare(players){
//                if player[currTeam] == 1824 {   //sub 1842 for teamID passed from button
//                    data.append(player[name])
//                    data.append(String(player[points]))
//                    data.append(String(player[goals]))
//                    data.append(String(player[assists]))
//                }
//            }
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
