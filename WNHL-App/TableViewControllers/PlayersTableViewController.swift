//
//  PlayersTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-25.
//

import UIKit


class PlayersTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var PlayerTableView: UITableView!
    // May not need this below
    var playerNameString:String!
    var players = ["Daniel Figueroa","Sawyer Fenwick","Ian Snow","Smittywerbenjeagermanjensen","John Locke", "Ferdinand von Aegir","Jim Raynor", "Acturus Mengsk","Sarah Kerrigan","Valerian Mengsk","Lucina Fire Emblem","Luz Angelica","Lysithea von Ordelia","Ann Takamaki","Han Solo","Darth Sidious","David Falt","Danielle Davis", "Danimalia", "Luana Liuna"]
    var filteredPlayers: [String]!

    let reuseIdentifier = "playerCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredPlayers = players
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlayers.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = PlayerTableView.indexPathForSelectedRow
        let currentCell = self.PlayerTableView.cellForRow(at:indexPath!) as! PlayerTableViewCell
        playerNameString = currentCell.playerText.text
        // This will segue to the Navigation controller for the Single Player Front and Back Views
        self.performSegue(withIdentifier: "singlePlayerSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlayerTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlayerTableViewCell
        cell.noSelectionStyle()
        cell.playerText.text = filteredPlayers[indexPath.row]
        cell.playerText.textColor = UIColor.white
        cell.playerText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.chevronImage.image = UIImage(systemName: "chevron.right")
        cell.chevronImage.tintColor = UIColor.white
        return cell
    }
    
    // This function will be called just prior to the segue performed in the didSelectRowAt function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the navigation controller holding the View Controllers for Single Player selection
        let navigationController = segue.destination as! UINavigationController
        // Get a reference to the second view controller now that we have the Navigation controller that contains it
        let secondViewController = navigationController.viewControllers.first as! SinglePlayerFrontViewController

        // Set a variable in the second view controller with the String to pass
        secondViewController.playerNameString = playerNameString
    }
    
    func searchTableView(searchText:String){
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredPlayers = searchText.isEmpty ? players : players.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
}
