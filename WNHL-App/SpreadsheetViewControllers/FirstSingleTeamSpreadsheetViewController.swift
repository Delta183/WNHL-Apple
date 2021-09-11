//
//  SingleTeamSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-27.
//

import UIKit
import SQLite

class FirstSingleTeamSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet var singleTeamCollectionView: UICollectionView!
    let reuseIdentifier = "teamSpreadsheetCell"
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    
    //var data: [String] = []
    var data = ["1", "Merritt Islanders", " 11", "6", "2", "3", "15", "50", "35",]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Team title
        if indexPath.row == 1 || ((indexPath.row - 1) % 9) == 0 {
            cellWidth = 145
        }
        // 2 letter titles (GP, GF, GA)
        else if indexPath.row == 2 || indexPath.row == 7 || indexPath.row == 8 || ((indexPath.row - 2) % 9) == 0 || ((indexPath.row - 7) % 9) == 0 || ((indexPath.row - 8) % 9) == 0{
            cellWidth = 32
        }
        // 1 Letter titles (W, L, T)
        else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ||
                    ((indexPath.row - 3) % 9) == 0 || ((indexPath.row - 4) % 9) == 0 || ((indexPath.row - 5) % 9) == 0{
            cellWidth = 23
        }
        // 3 letter titles (Pos, PTS)
        else{
            cellWidth = 32
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TeamSpreadsheetCollectionViewCell1
        cell.dataLabel1.text = self.data[indexPath.row]
        return cell
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
    }
}
