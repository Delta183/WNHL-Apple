//
//  Extensions.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-04.
//

import Foundation
import Swift
import UIKit
import SQLite

// Put to parent view
extension UIViewController{
    func showToast(message : String, font: UIFont) {
        // This may have to change to be 1/10 of the width
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/10 , y: self.view.frame.size.height-100, width: 325, height: 35))
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
    
    // Function to give the view a special background colour dependent on the team that was selected.
    func getColorFromTeamId(teamNameString: String) -> UIColor{
        if teamNameString.caseInsensitiveCompare("Atlas Steelers")  == ComparisonResult.orderedSame{
            return UIColor(red: 216.0/255.0, green: 134.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        }
        else if teamNameString.caseInsensitiveCompare("Townline Tunnelers") == ComparisonResult.orderedSame{
            return UIColor(red: 0.0/255.0, green: 55.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        }
        else if teamNameString.caseInsensitiveCompare("Crown Room Kings") == ComparisonResult.orderedSame{
            return UIColor(red: 21.0/255.0, green: 21.0/255.0, blue: 21.0/255.0, alpha: 1.0)
        }
        else if teamNameString.caseInsensitiveCompare("Dain City Dusters") == ComparisonResult.orderedSame{
            return UIColor(red: 224.0/255.0, green: 76.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
        else if teamNameString.caseInsensitiveCompare("Lincoln Street Legends") == ComparisonResult.orderedSame{
            return UIColor(red: 96.0/255.0, green: 96.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        }
        else if teamNameString.caseInsensitiveCompare("Merritt Islanders") == ComparisonResult.orderedSame{
            return UIColor(red: 241.0/255.0, green: 104.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        }
        else{
            return UIColor.systemOrange
        }
    }
}


// extension will allow this to be an extension to all UITableViewControllers such that they can all use this function.
extension UITableViewController{
    
    func scheduleLocal(dateTimeString:String, notificationId:String, titleString:String) {
        let defaults = UserDefaults.standard
        let currentDate = Date()
        // game at 5:17PM tomorrow reads 22 hours when called at 6:17PM the day before.
        let date = convertStringToDate(dateStr: dateTimeString)
        // This will make it impossible for any past games to be scheduled by checking if the time between now and the time of the given date
        if date.timeIntervalSinceNow.isLessThanOrEqualTo(0) == false {
            let content = UNMutableNotificationContent()
            content.title = titleString
            
            content.sound = UNNotificationSound.default
            // Furthermore, there will be a series of checks for an more than hour, more than 10 minutes and then within those 10 minutes
            var modifiedDate:Date!
            var triggerDate:DateComponents!
            var trigger:UNCalendarNotificationTrigger!
            // If there is more than an hour left, set the alert to be an hour prior to the game
            if date.hours(from: currentDate) > 0{
                content.body = "1 hour until the match begins."
//                content.body = "1 hour until the match begins."
                modifiedDate = Calendar.current.date(byAdding: .hour, value: -1, to: date)
                triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: modifiedDate)
                trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                defaults.setValue(true, forKey: notificationId)
            }
            // If there is less than an hour left, but more than 10 minutes before the match begins, set the alert to be an hour prior to the game
            else if date.minutes(from: currentDate) > 10{
                content.body = "10 minutes until the match begins"
                modifiedDate = Calendar.current.date(byAdding: .minute, value: -10, to: date)
                triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: modifiedDate)
                trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                defaults.setValue(true, forKey: notificationId)
            }
            // Otherwise the user has less than 10 minutes meaning there is no reason to set a notification
            else{
                content.body = "The match is in less than 10 minutes."
                trigger = nil
            }
            let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                if let error = error {
                    // Something went wrong
                    print(error)
                }
            })
        }
    }
    
    func deleteNotification(notificationId:String){
        let idArray:[String] = [notificationId]
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: idArray)
    }
    
    func deletePastSetNotifications(idList:[Int64]){
        let defaults = UserDefaults.standard
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        for n in 0..<idList.count {
            // If there is some data here, it mean it still exists and there may be a possibility a cancelled notification had past its time or an active one past its time
            let idString = String(idList[n])
            if defaults.object(forKey: idString) != nil{
                let gameDate = getFullDateTimeStringFromTeamId(gameId: idList[n])
                let dateFromString = dateFormatter.date(from: gameDate)
                // Check if the date of this notification is prior to current date. As in this very instant
                if dateFromString?.timeIntervalSinceNow.isLessThanOrEqualTo(0) == true{
                    // if the time since this notification to now is 0 or a negative, it means the notification has passed.
                    // Thus we remove the object entirely
                    defaults.removeObject(forKey: String(idList[n]))
                }
            }
        } // end of for loop
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
    
    // This function will take the string given representing a Youtube Channel ID and use it to take the user to it
    func goToYoutubeChannel(youtubeChannelId:String) {
        // appURL is the url for the Youtube app in particular
        let appURL = NSURL(string: "youtube://www.youtube.com/channel/\(youtubeChannelId)")!
        // webURL is the url for initializing Youtube on the browser.
        let webURL = NSURL(string: "https://www.youtube.com/channel/\(youtubeChannelId)")!
        let application = UIApplication.shared
        // Check if the Youtube app can be opened first. This means the user has it installed already.
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }

    // This function will take the user to a Twitter account given the handle represented by a String
    func goToTwitterAccount(twitterUserID:String) {
        // appURL is the url for the Twitter app in particular
        let appURL = NSURL(string: "twitter://user?screen_name=\(twitterUserID)")!
        // webURL is the url for the browser variant of Twitter
        let webURL = NSURL(string: "https://twitter.com/\(twitterUserID)")!
        
        let application = UIApplication.shared
        
        // Try to open the Twitter app first if it is installed, otherwise if that fails, open the Twitter account on browser.
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
    }

    // This function will simply redirect the user to the Google Spreadsheet for WNHL Fantasy in browser.
    func goToFantasySpreadsheet(){
        let webURL = NSURL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQ8bY-Of5YbJHk0VTj0LxWyQLYkK2dzWea-2fjd899X3qWMXGysbmE2UhqCdsFBLtJ233WjsGA_IMYJ/pubhtml?gid=0&single=true")!
        let application = UIApplication.shared
        application.open(webURL as URL)
    }
    
    func convertStringToDate(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current// (abbreviation: "GMT+0:00")
        let dateFromString = dateFormatter.date(from: dateStr)
        return dateFromString!
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

extension NotificationsViewController:ChildToParentProtocol {
    
    func needToPassInfoToParent(with isNowChecked:Bool, teamNameString:String) {
        if isNowChecked{
            self.showToast(message: teamNameString + " Notifications ON", font: .systemFont(ofSize: 13.0))
        }
        else{
            self.showToast(message: teamNameString + " Notifications OFF", font: .systemFont(ofSize: 13.0))
        }
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}
