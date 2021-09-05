//
//  Extensions.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-04.
//

import Foundation
import Swift
import UIKit

extension NotificationsViewController:ChildToParentProtocol {
    
    func needToPassInfoToParent(with isNowChecked:Bool, teamNameString:String) {
        if isNowChecked{
            self.showToast(message: teamNameString + " Notifications ON", font: .systemFont(ofSize: 15.0))
        }
        else{
            self.showToast(message: teamNameString + " Notifications OFF", font: .systemFont(ofSize: 15.0))
        }
    }
}

// Put to parent view
extension UIViewController{
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 55, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func getImageNameFromTeamName(teamName:String) -> String {
        if teamName.caseInsensitiveCompare("Atlas Steelers")  == ComparisonResult.orderedSame{
            return "steelers_logo"
        }
        else if teamName.caseInsensitiveCompare("Townline Tunnelers") == ComparisonResult.orderedSame{
            return "townline_logo"
        }
        else if teamName.caseInsensitiveCompare("Crown Room Kings") == ComparisonResult.orderedSame{
            return "crownRoom_logo"
        }
        else if teamName.caseInsensitiveCompare("Dain City Dusters") == ComparisonResult.orderedSame{
            return "dusters_logo"
        }
        else if teamName.caseInsensitiveCompare("Lincoln Street Legends") == ComparisonResult.orderedSame{
            return "legends_logo"
        }
        else if teamName.caseInsensitiveCompare("Merritt Islanders") == ComparisonResult.orderedSame{
            return "islanders_logo"
        }
        else{
            return "WNHL_Logo"
        }
    }
}


extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            self.init(data: try Data(contentsOf: url))
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

// extension will allow this to be an extension to all UITableViewControllers such that they can all use this function.
extension UITableViewController{
    // This function will return a string of the image set name given a string of a team name.
    func getImageNameFromTeamNameTable(teamName:String) -> String {
        // Each check of team name is case insensitive.
        if teamName.caseInsensitiveCompare("Atlas Steelers")  == ComparisonResult.orderedSame{
            return "steelers_logo"
        }
        else if teamName.caseInsensitiveCompare("Townline Tunnelers") == ComparisonResult.orderedSame{
            return "townline_logo"
        }
        else if teamName.caseInsensitiveCompare("Crown Room Kings") == ComparisonResult.orderedSame{
            return "crownRoom_logo"
        }
        else if teamName.caseInsensitiveCompare("Dain City Dusters") == ComparisonResult.orderedSame{
            return "dusters_logo"
        }
        else if teamName.caseInsensitiveCompare("Lincoln Street Legends") == ComparisonResult.orderedSame{
            return "legends_logo"
        }
        else if teamName.caseInsensitiveCompare("Merritt Islanders") == ComparisonResult.orderedSame{
            return "islanders_logo"
        }
        else{
            return "WNHL_Logo"
        }
    }
    
    func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let date = Date()
        let calendar = Calendar.current
        let hourValue = calendar.component(.hour, from: date)
        let minuteValue = calendar.component(.minute, from: date)
        var dateComponents = DateComponents()
        dateComponents.hour = hourValue
        dateComponents.minute = minuteValue
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func showLocationOnMaps(primaryContactFullAddress: String) {
        let testURL: NSURL = NSURL(string: "maps://maps.apple.com/?q=")!
        if UIApplication.shared.canOpenURL(testURL as URL) {
            if let address = primaryContactFullAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                let directionsRequest: String = "maps://maps.apple.com/?q=" + (address)
                let directionsURL: NSURL = NSURL(string: directionsRequest)!
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(directionsURL as URL)) {
                    application.open(directionsURL as URL, options: [:], completionHandler: nil)
                }
            }
        } else {
            NSLog("Can't open Apple Maps on this device")
        }
    }
}

// This extension will allow all UITableViewCells, even the customs ones made, use the functions within
extension UITableViewCell {
    // This function simply toggles the selection style to be that of none so that there won't be a grey highlight on click.
    func noSelectionStyle() {
        self.selectionStyle = .none
    }
}
// Make all tables scroll

extension UIButton {
    
    private class Action {
        var action: (UIButton) -> Void
        
        init(action: @escaping (UIButton) -> Void) {
            self.action = action
        }
    }
    
    private struct AssociatedKeys {
        static var ActionTapped = "actionTapped"
    }
    
    private var tapAction: Action? {
        set { objc_setAssociatedObject(self, &AssociatedKeys.ActionTapped, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &AssociatedKeys.ActionTapped) as? Action }
    }
    
    
    @objc dynamic private func handleAction(_ recognizer: UIButton) {
        tapAction?.action(recognizer)
    }
    
    
    func mk_addTapHandler(action: @escaping (UIButton) -> Void) {
        self.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        tapAction = Action(action: action)
        
    }
}
