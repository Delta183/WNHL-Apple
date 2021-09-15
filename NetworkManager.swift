//
//  Connectivity.swift
//  WNHL-App
//
//  Created by sawyer on 2021-09-13.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    var manager = NetworkReachabilityManager(host: "www.wnhlwelland.ca")
    fileprivate var isReachable = false
    
    //MARK:- startMonitoring
    func startMonitoring(){
        self.manager?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: {(networkStatus) in
            
            if networkStatus == .reachable(.cellular) || networkStatus == .reachable(.ethernetOrWiFi) {
                self.isReachable = true
            }
            else {
                self.isReachable = false
            }
        })
    }
    
    func isConnected() -> Bool {
        return self.isReachable
    }
    
}
