//
//  Country.swift
//  alamoTest
//
//  Created by sawyer on 2021-09-04.
//

import Foundation

struct Venues: Decodable {
    var name: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
    
}

