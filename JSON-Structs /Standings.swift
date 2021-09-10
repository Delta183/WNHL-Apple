//
//  Standings.swift
//  alamoTest
//
//  Created by sawyer on 2021-09-06.
//

import Foundation

struct Standings: Decodable {
    let id: Int
    let data: [String: StandingData]?
    let seasons: [Int]
    
    enum CodingKeys: String, CodingKey{
        case id
        case data
        case seasons
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        seasons = try container.decode([Int].self, forKey: .seasons)
        do{
            data = try container.decode([String: StandingData].self, forKey: .data)
        }
        catch {
            data = nil
        }
    }
    
    struct StandingData: Decodable {
        let pos: String?
        let name: String
        let gp: String
        let w: String
        let l: String
        let ties: String
        let pts: String
        let gf: String
        let ga: String
        
        enum CodingKeys: String, CodingKey{
            case name
            case gp
            case w
            case l
            case ties
            case pts
            case gf
            case ga
            case pos
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            gp = try container.decode(String.self, forKey: .gp)
            w = try container.decode(String.self, forKey: .w)
            l = try container.decode(String.self, forKey: .l)
            ties = try container.decode(String.self, forKey: .ties)
            pts = try container.decode(String.self, forKey: .pts)
            gf = try container.decode(String.self, forKey: .gf)
            ga = try container.decode(String.self, forKey: .ga)
            name = try container.decode(String.self, forKey: .name)
            do {
                pos = try String(container.decode(Int.self, forKey: .pos))
            } catch DecodingError.typeMismatch {
                pos = try container.decode(String.self, forKey: .pos)
            }
        }
    }
}

