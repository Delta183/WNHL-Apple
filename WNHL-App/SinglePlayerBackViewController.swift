//
//  SinglePlayerBackViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-28.
//

import UIKit

class SinglePlayerBackViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("boi")
        print(type(of: self.view))
        let button = backButton;
        button?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("youch")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonClicked() {
        print("hey")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
