//
//  PlayersViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-25.
//

import UIKit

class PlayersViewController: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
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


