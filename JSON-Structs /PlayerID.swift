//
//  PlayerID.swift
//  WNHL-App
//
//  Created by sawyer on 2021-09-08.
//

import Foundation

struct PlayerID: Decodable {
    let data: [String: Names]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    struct Names: Decodable {
        let name: String

        enum CodingKeys: String, CodingKey {
            case name
        }
    }
}
