//
//  SpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-11.
//

import UIKit

class SpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var positions = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA",
                     "1", "Merritt Islanders", " 11", "6", "2", "3", "15", "50", "35",
                     "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
                     "3", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33", "34",
                     "4", "Atlas Steelers", "11", "4", "4", "3", "11", "37", "37",
                     "5", "Dain City Dusters", "11", "3", "6", "2", "8", "23", "33",
                     "6", "Crown Room Kings", "11", "1", "6", "4", "6", "22", "30",

]
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.positions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            var cellWidth:CGFloat = CGFloat()

        if indexPath.row == 1 || ((indexPath.row - 1) % 9) == 0 {
            cellWidth = 160
           }
        else if indexPath.row == 2 || indexPath.row == 7 || indexPath.row == 8 || ((indexPath.row - 2) % 9) == 0 || ((indexPath.row - 7) % 9) == 0 || ((indexPath.row - 8) % 9) == 0{
            cellWidth = 27
        }
        else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ||
                    ((indexPath.row - 3) % 9) == 0 || ((indexPath.row - 4) % 9) == 0 || ((indexPath.row - 5) % 9) == 0{
            cellWidth = 21
        }
       else{
        cellWidth = 34
       }
           return CGSize(width: cellWidth, height: 24)
        }
    

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.posLabel.text = self.positions[indexPath.row] // The row value is the same as the index of the desired text within the array.
        cell.backgroundColor = UIColor.white // make cell more visible in our example project
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
          
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
