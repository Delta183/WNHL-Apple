//
//  BaseViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-03.
//

//
//  ViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-07-26.
//

import UIKit

class BaseViewController: UIViewController, UITabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTabBar = UITabBar()
        myTabBar.frame = CGRect(x: 0, y: 60, width:self.view.frame.size.width, height: 50)

        let one = UITabBarItem()
        one.title = "one"
        one.tag = 1
        myTabBar.setItems([one], animated: false)
        self.view.addSubview(myTabBar)
        myTabBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            switch item.tag  {
            case 1:
                let controller = storyboard?.instantiateViewController(withIdentifier: "MoreViewController")
                addChild(controller!)
                view.addSubview((controller?.view)!)
                controller?.didMove(toParent: self)
                break
            default:
                break
            }

        }

}


