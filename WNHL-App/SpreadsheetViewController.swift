//
//  SpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-11.
//

import UIKit

class SpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet var CollectionView1: UICollectionView?
    @IBOutlet var CollectionView2: UICollectionView?
    @IBOutlet var CollectionView3: UICollectionView?
    @IBOutlet var CollectionView4: UICollectionView?
    @IBOutlet var CollectionView5: UICollectionView?
    let reuseIdentifier1 = "cell"
    let reuseIdentifier2 = "cell2"
    let reuseIdentifier3 = "cell3"
    let reuseIdentifier4 = "cell4"
    var positions = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA",
                     "1", "Merritt Islanders", " 11", "6", "2", "3", "15", "50", "35",
                     "2", "Townline Tunnelers", "11", "5", "2", "4", "14", "30", "26",
                     "3", "Lincoln Street Legends", "11", "5", "4", "2", "12", "33", "34",
                     "4", "Atlas Steelers", "11", "4", "4", "3", "11", "37", "37",
                     "5", "Dain City Dusters", "11", "3", "6", "2", "8", "23", "33",
                     "6", "Crown Room Kings", "11", "1", "6", "4", "6", "22", "30",]
    var positions2 = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA",
                     "1", "Atlas Steelers", "6", "6", "0", "0", "12", "38", "11",
                     "2", "Townline Tunnelers", "6", "4", "2", "0", "8", "21", "20",
                     "3", "Welland Stelcobras", "6", "1", "5", "0", "2", "12", "25",
                     "4", "Crown Room Kings", "6", "1", "5", "0", "2", "14", "29",
                     ]
    var positions3 = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA",
                     "1", "Atlas Steelers", "28", "18", "7", "3", "39", "166", "97",
                     "2", "Townline Tunnelers", "28", "18", "7", "3", "39", "159", "126",
                     "3", "Crown Room Kings", "28", "10", "13", "5", "25", "121", "141",
                     "4", "Welland Stelcobras", "28", "3", "22", "3", "9", "82", "164",
                     ]
    var positions4 = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA",
                     "1", "Welland Undertakers", "6", "3", "2", "1", "7", "24", "21",
                     "2", "Welland River Rats", "6", "2", "3", "1", "5", "23", "26",
                     ]
    var positions5 = ["Pos", "Team", "GP", "W", "L", "T", "PTS", "GF", "GA",
                      "1", "Welland Undertakers", "30", "14", "9", "7", "35", "189", "161",
                      "2", "Welland River Rats", "30", "9", "17", "4", "22", "143", "179",
                     ]
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CollectionView1 {
            return self.positions.count
        }
        else if collectionView == CollectionView2{
            return self.positions2.count
        }
        else if collectionView == CollectionView3{
            return self.positions3.count
        }
        else if collectionView == CollectionView4 {
            return self.positions4.count
        }
        else{
            return self.positions5.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            var cellWidth:CGFloat = CGFloat()
        // Team title
        if indexPath.row == 1 || ((indexPath.row - 1) % 9) == 0 {
            cellWidth = 145
           }
        // 2 letter title
        else if indexPath.row == 2 || indexPath.row == 7 || indexPath.row == 8 || ((indexPath.row - 2) % 9) == 0 || ((indexPath.row - 7) % 9) == 0 || ((indexPath.row - 8) % 9) == 0{
            cellWidth = 32
        }
        // 1 Letter titles
        else if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ||
                    ((indexPath.row - 3) % 9) == 0 || ((indexPath.row - 4) % 9) == 0 || ((indexPath.row - 5) % 9) == 0{
            cellWidth = 23
        }
        // 3 letter title
       else{
        cellWidth = 32
       }
           return CGSize(width: cellWidth, height: 24)
        }
    

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.CollectionView1 {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell1

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.posLabel.text = self.positions[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell.backgroundColor = UIColor.white // make cell more visible in our example project
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            return cell
        }
        else if collectionView == self.CollectionView2{
            // get a reference to our storyboard cell
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell2

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell2.posLabel2.text = self.positions2[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell2.backgroundColor = UIColor.white // make cell more visible in our example project
            cell2.layer.borderColor = UIColor.black.cgColor
            cell2.layer.borderWidth = 1
            return cell2
        }
        else if collectionView == self.CollectionView3{
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell3

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell3.posLabel3.text = self.positions3[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell3.backgroundColor = UIColor.white // make cell more visible in our example project
            cell3.layer.borderColor = UIColor.black.cgColor
            cell3.layer.borderWidth = 1
            return cell3
        }
        else if collectionView == self.CollectionView4{
            let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell4

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell4.posLabel4.text = self.positions4[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell4.backgroundColor = UIColor.white // make cell more visible in our example project
            cell4.layer.borderColor = UIColor.black.cgColor
            cell4.layer.borderWidth = 1
            return cell4
        }
        else{
            let cell5 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath as IndexPath) as! SpreadsheetCollectionViewCell5

            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell5.posLabel5.text = self.positions5[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell5.backgroundColor = UIColor.white // make cell more visible in our example project
            cell5.layer.borderColor = UIColor.black.cgColor
            cell5.layer.borderWidth = 1
            return cell5
        }
        
    }

    
    // MARK: - UICollectionViewDelegate protocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView1?.delegate = self;
        CollectionView1?.dataSource = self;
        CollectionView2?.delegate = self;
        CollectionView2?.dataSource = self;
        CollectionView3?.delegate = self;
        CollectionView3?.dataSource = self;
        CollectionView4?.delegate = self;
        CollectionView4?.dataSource = self;
        CollectionView5?.delegate = self;
        CollectionView5?.dataSource = self;


          
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
