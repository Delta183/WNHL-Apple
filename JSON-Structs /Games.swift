//
//  Games.swift
//  alamoTest
//
//  Created by sawyer on 2021-09-05.
//

import Foundation

struct Games: Decodable {
    let id: Int
    let data: [IDs]
    
  enum CodingKeys: String, CodingKey {
    case id
    case data
  }
    
  struct IDs: Decodable {
    let ID: Int
        
    enum CodingKeys: String, CodingKey {
        case ID
    }
  }
    
}

