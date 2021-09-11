//
//  StatisticsSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit
import SQLite

// This class will create and populate the spreadsheets for the Statistics View
class StatisticsSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var GoalsCollectionView: UICollectionView?
    @IBOutlet var AssistsCollectionView: UICollectionView?
    @IBOutlet var PointsCollectionView: UICollectionView?
    var reuseIdentifier1 = "goalsCell"
    var reuseIdentifier2 = "assistsCell"
    var reuseIdentifier3 = "pointsCell"
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let players = Table("Players")
    let name = Expression<String>("name")
    let currTeam = Expression<Int64>("currTeam")
    let goal = Expression<Int64>("goals")
    let assist = Expression<Int64>("assists")
    let point = Expression<Int64>("points")
    // The 3 arrays are for the Goals, Assists and Points spreadsheets respectively.
    var goals: [String] = []
    var assists: [String] = []
    var points: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == GoalsCollectionView{
            return self.goals.count
        }
        else if collectionView == AssistsCollectionView{
            return self.assists.count
        }
        else{
            return self.points.count
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
            cell.dataLabel1.text = self.goals[indexPath.row] // The row value is the same as the index of the desired text within the array.
            return cell
        }
        else if collectionView == self.AssistsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! AssistsCollectionViewCell
            cell.dataLabel2.text = self.assists[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! PointsCollectionViewCell
            cell.dataLabel3.text = self.points[indexPath.row]
            return cell
        }
    }
    
    func getGoals(){
        do {
            let db = try Connection("\(path)/wnhl.sqlite3")
            
            let sortedPlayers = Table("Players").order(goal)
            
            var count = try! db.scalar(sortedPlayers.count)
        
            for player in try db.prepare(sortedPlayers) {
                goals.append(String(player[goal]))
                goals.append(getTeamNameFromTeamId(teamId: player[currTeam]))
                goals.append(player[name])
                goals.append(String(count))
                count-=1
            }
            goals.reverse()
        }
        catch {
            print(error)
        }
    }
    
    func getAssists(){
        do {
            let db = try Connection("\(path)/wnhl.sqlite3")
            
            let sortedPlayers = Table("Players").order(assist)
            
            var count = try! db.scalar(sortedPlayers.count)
            
            for player in try db.prepare(sortedPlayers) {
                assists.append(String(player[assist]))
                assists.append(getTeamNameFromTeamId(teamId: player[currTeam]))
                assists.append(player[name])
                assists.append(String(count))
                count-=1
            }
            assists.reverse()
        }
        catch {
            print(error)
        }
    }
    
    func getPoints(){
        do {
            let db = try Connection("\(path)/wnhl.sqlite3")
            
            let sortedPlayers = Table("Players").order(point)
            
            var count = try! db.scalar(sortedPlayers.count)
            
            for player in try db.prepare(sortedPlayers) {
                points.append(String(player[point]))
                points.append(getTeamNameFromTeamId(teamId: player[currTeam]))
                points.append(player[name])
                points.append(String(count))
                count-=1
            }
            points.reverse()
        }
        catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        getGoals()
        getAssists()
        getPoints()
        super.viewDidLoad()
        GoalsCollectionView?.delegate = self;
        GoalsCollectionView?.dataSource = self;
        AssistsCollectionView?.delegate = self;
        AssistsCollectionView?.dataSource = self;
        PointsCollectionView?.delegate = self;
        PointsCollectionView?.dataSource = self;
    }
}
