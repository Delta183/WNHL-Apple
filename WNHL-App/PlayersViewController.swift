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
        self.searchBar.delegate = self // set delegate
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonClicked() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // When button "Search" pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
}
