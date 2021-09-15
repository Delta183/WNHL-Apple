//
//  LaunchViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-03.
//

import UIKit
import SQLite
import Reachability

class LaunchViewController: UIViewController {
    
    //Path to DB
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let reachability = try! Reachability()
    public var downloading: Bool = true
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reachability.stopNotifier()
    }
    
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.white], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    // Called once the view is prepared
    override func viewDidAppear(_ animated: Bool) {
        print("view appeared")
        if(NetworkManager.shared.isConnected() == false){
            waitForConnection()
        }
        else {
            do_stuff {
                
            }
        }
        //self.performSegue(withIdentifier: "mainSegue", sender: self)
        
    }
        
    func waitForConnection(){
        textLabel.text = "Waiting for Connection..."
        while(NetworkManager.shared.isConnected() == false){
            //do nothing
        }
        do_stuff {
            
        }
    }
    
    func do_stuff(onCompleted: () -> ()) {
        
        let service = Service(baseUrl: "http://www.wnhlwelland.ca/wp-json/sportspress/v2/", launchView: self)
        if self.isAppAlreadyLaunchedOnce() {
            //Update DB
            service.updateDatabase(updateMain: true)
        }
        else {
            //Create DB
            SQLiteDatabase.init()
            //Begin Network Calls
            service.buildDatabase(update: false)
            //The onCompleted flag is necessary
        }
        onCompleted()
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
            return true
        }else{
            return false
        }
    }
    
    func goToNext(){
        self.textLabel.text = "Finishing Up..."
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.textLabel.text = "Complete!"
            self.performSegue(withIdentifier: "mainSegue", sender: self)
        }
    }
}
