//
//  SpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-11.
//

import UIKit

class StandingsSpreadsheetViewController: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    let screenSize: CGRect = UIScreen.main.bounds
    // Outlets for all the collection views on the Standings View

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var CollectionView1: UICollectionView!
    @IBOutlet var headerCollectionView: UICollectionView!
    // reuseIdentifiers for the respective cells of the collection views such that they can be referenced here
    let reuseIdentifier1 = "cell"
    let reuseIdentifier2 = "headerCell"
    var fontSize:CGFloat!
    var headerItems = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA"]

    
    // The arrays housing the data for each respective collection view
    var spreadsheetData:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func reloadCollectionView() -> Void {
        self.CollectionView1.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // Set the number of items in the sole section, in other words, tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Only make as many cells that the amount of the specific array for each collection view.
        // This is because not all the spreadsheets will have the same amount of data
        if collectionView == CollectionView1 {
            return self.spreadsheetData.count
        }
        else{
            return self.headerItems.count
        }
    }
    
    
    // This function will set the layout the cells for the 5 spreadsheets of this class
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let containerWidth = screenSize.width - 40

        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Team title
        if indexPath.row == 1 || ((indexPath.row - 1) % 9) == 0 {
            // 145
            cellWidth = containerWidth * (0.387)
        }
        // 1 Letter titles (W,L,T)
        else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ||
                    ((indexPath.row - 3) % 9) == 0 || ((indexPath.row - 4) % 9) == 0 || ((indexPath.row - 5) % 9) == 0{
            // 23
            cellWidth = containerWidth * (0.0625 )
        }
        // 2 letter titles (GP, GF, GA)
        // 3 letter title (PTS, Pos)
        else{
            // 32
            cellWidth = containerWidth * (0.085 )
        }
        // Set the size of the cell to be of the determined width though all cells will have the exact same height of 24.
        return CGSize(width: cellWidth, height: 22)
    }
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if screenSize.width < 414 {
            fontSize = 10
        }
        else{
            fontSize = 12
        }
        if collectionView == self.CollectionView1 {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell1
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.posLabel.text = self.spreadsheetData[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell.posLabel.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! headerStandings
            cell.headerLabel.text = self.headerItems[indexPath.row]
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
    }
 
    
}
