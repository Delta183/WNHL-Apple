//
//  PlayersViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-25.
//

import UIKit

class PlayersViewController: UIViewController,UISearchBarDelegate {
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playerLabel: UILabel!
    var fontSize:CGFloat = 28

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = backButton;
        if screenSize.width < 414 {
            fontSize = 24
        }
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        playerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.searchBar.delegate = self
    }
    
    @objc func buttonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // When button "Search" pressed, the keyboard will dismiss as well.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        (children.first as? PlayersTableViewController)?.searchTableView(searchText: searchText)
    }
    
    
}


