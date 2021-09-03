//
//  LaunchViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-03.
//

import UIKit

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
        sleep(3)
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
