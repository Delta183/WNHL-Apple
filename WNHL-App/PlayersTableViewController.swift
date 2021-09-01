//
//  PlayersTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-25.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    
    @IBOutlet var PlayerTableView: UITableView!
    var playerNameString:String!
    var players = ["Daniel Figueroa","Sawyer Fenwick","Ian Snow","Smittywerbenjeagermanjensen","John Locke", "Ferdinand von Aegir","Jim Raynor", "Acturus Mengsk","Sarah Kerrigan","Valerian Mengsk","Lucina Fire Emblem","Luz Angelica","Lysithea von Ordelia","Ann Takamaki","Han Solo","Darth Sidious"]
    let reuseIdentifier = "playerCell"
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = PlayerTableView.indexPathForSelectedRow
        let currentCell = self.PlayerTableView.cellForRow(at:indexPath!) as! PlayerTableViewCell
        // Segue to the second view controller
        playerNameString = currentCell.playerText.text
        self.performSegue(withIdentifier: "singlePlayerSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlayerTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlayerTableViewCell
        cell.noSelectionStyle()
        cell.playerText.text = players[indexPath.row]
        cell.playerText.textColor = UIColor.white
        cell.playerText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.chevronImage.image = UIImage(systemName: "chevron.right")
        cell.chevronImage.tintColor = UIColor.white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get a reference to the second view controller
        let navigationController = segue.destination as! UINavigationController
        let secondViewController = navigationController.viewControllers.first as! SinglePlayerViewController

        // Set a variable in the second view controller with the String to pass
        secondViewController.playerNameString = playerNameString
    }
    
}
