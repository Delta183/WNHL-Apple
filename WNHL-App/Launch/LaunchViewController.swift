//
//  LaunchViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-03.
//

import UIKit
import SQLite

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    // Downloading Data for first time
    // Checking for Updates subsequent runs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        self.view.backgroundColor = .systemOrange
        
        self.view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 60),
            loadingIndicator.heightAnchor.constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
        loadingIndicator.animateStroke()
        if isAppAlreadyLaunchedOnce() {
            textLabel.text = "Checking for Updates..."
        }
        else{
            textLabel.text = "Downloading Data..."

        }
    }
    
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.white], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    // Called once the view is prepared
    override func viewDidAppear(_ animated: Bool) {
        //print("Before stuff")
        do_stuff {
            // Now the "function" has completed.
            //print("After stuff")
        }
        self.performSegue(withIdentifier: "mainSegue", sender: self)
        
    }
    
    func do_stuff(onCompleted: () -> ()) {
        // This body not counting the onCompleted tag is where you will set up the database loading.
        //Create DB
        SQLiteDatabase.init()
        //Path to DB
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            //Column Names
            //Table Column Names
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")
            let slug = Expression<String>("slug")
            let seasonID = Expression<String>("seasonID")
            let title = Expression<String>("title")
            let home = Expression<Int64>("home")
            let away = Expression<Int64>("away")
            let homeScore = Expression<Int64>("homeScore")
            let awayScore = Expression<Int64>("awayScore")
            let date = Expression<String>("date")
            let time = Expression<String>("time")
            let location = Expression<Int64>("location")
            let mediaID = Expression<Int64>("mediaID")
            let mediaURL = Expression<String>("mediaURL")
            let content = Expression<String>("content")
            let leagues = Expression<String>("leagues")
            let number = Expression<Int64>("number")
            let prevTeams = Expression<String>("prevTeams")
            let currTeam = Expression<Int64>("currTeam")
            let goals = Expression<Int64>("goals")
            let assists = Expression<Int64>("assists")
            let points = Expression<Int64>("points")
            //Table Names
            let venues = Table("Venues")
            let teams = Table("Teams")
            let games = Table("Games")
            for venue in try db.prepare(venues){
                print("id: \(venue[id]), name: \(venue[name])")
            }
            for team in try db.prepare(teams){
                print("id: \(team[id]), slug: \(team[slug])")
            }
            for game in try db.prepare(games){
                print("date: \(game[date]), time: \(game[time]), location: \(game[location]) , title: \(game[title])")
                let title = game[title]
                print(title)
            }
            
        }
        catch {
            print(error)
        }
        // The onCompleted flag is necessary
        onCompleted()
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
            //print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            //print("App launched first time")
            return false
        }
    }
}
