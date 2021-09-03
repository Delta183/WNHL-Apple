//
//  StandingsViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-03.
//

import UIKit

class StandingsViewController: UIViewController {

    @IBOutlet weak var StandingsScrollView: UIScrollView!
    override func viewDidLoad() {
        // Effectively allow the scroll view to actually scroll by increasing the size of the content to be bigger than the base height
        StandingsScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+550)
        super.viewDidLoad()
    }
}
