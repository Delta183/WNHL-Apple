//
//  Teams.swift
//  alamoTest
//
//  Created by sawyer on 2021-09-04.
//

import Foundation

struct Teams: Decodable {
    var name: [String: String]?
    var seasonIDs: [Int]?
    var id: Int?
    var slug: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case id = "id"
        case slug = "slug"
        case seasonIDs = "seasons"
    }
}

