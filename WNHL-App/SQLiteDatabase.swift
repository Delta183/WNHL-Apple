//
//  SQLiteDatabase.swift
//  WNHL-App
//
//  Created by sawyer on 2021-09-07.
//

import Foundation
import SQLite

class SQLiteDatabase {
    
    init(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        do {
            let db = try Connection("\(path)/wnhl.sqlite3")
            
            //Table Column Names
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")
            let slug = Expression<String>("slug")
            let seasonID = Expression<String>("seasonID")
            let title = Expression<String>("title")
            let home = Expression<Int64>("home")
            let away = Expression<Int64>("away")
            let homeScore = Expression<Int64>("homeScore")
            let awayScore = Expression<Int64>("awayScore")
            let date = Expression<String>("date")
            let time = Expression<String>("time")
            let location = Expression<Int64>("location")
            let mediaID = Expression<Int64>("mediaID")
            let mediaURL = Expression<String>("mediaURL")
            let content = Expression<String>("content")
            let leagues = Expression<String>("leagues")
            let number = Expression<Int64>("number")
            let prevTeams = Expression<String>("prevTeams")
            let currTeam = Expression<Int64>("currTeam")
            let goals = Expression<Int64>("goals")
            let assists = Expression<Int64>("assists")
            let points = Expression<Int64>("points")
            //let stats =
            //let data =
            
            //Table Names
            let venues = Table("Venues")
            let seasons = Table("Seasons")
            let games = Table("Games")
            let teams = Table("Teams")
            let players = Table("Players")
            let standings = Table("Standings")
            
            //Delete tables if exists
            try db.run(venues.drop(ifExists: true))
            try db.run(seasons.drop(ifExists: true))
            try db.run(games.drop(ifExists: true))
            try db.run(teams.drop(ifExists: true))
            try db.run(players.drop(ifExists: true))
            try db.run(standings.drop(ifExists: true))
            
            //Create Venues Table
            try db.run(venues.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
            })
            //Create Seasons Table
            try db.run(seasons.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
            })
            //Create Games Table
            try db.run(games.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(home)
                t.column(away)
                t.column(homeScore)
                t.column(awayScore)
                t.column(date)
                t.column(time)
                t.column(location)
            })
            //Create Teams Table
            try db.run(teams.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(slug)
                t.column(seasonID)
            })
            //Create Players Table
            try db.run(players.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(content)
                t.column(leagues)
                t.column(seasonID)
                t.column(number)
                t.column(prevTeams)
                t.column(currTeam)
                t.column(goals)
                t.column(assists)
                t.column(points)
                t.column(mediaID)
                t.column(mediaURL)
                //t.column(stats)
            })
            //Create Standings Table
            try db.run(standings.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(seasonID)
                //t.column(data)
            })
            //Populate Tables with Static Data -- FOR NOW
            //VENUES
            do{
                try db.run(venues.insertMany([[id <- 15, name <- "Welland"], [id <- 30, name <- "Pelham - Accipiter"], [id <- 35, name <- "Pelham - Duliban"], [id <- 39, name <- "Welland - Youth Arena"],[id <- 41, name <- "Port Colborne - Vale Center"], [id <- 42, name <- "Niagara Falls - Gale Center"]]))
            }
            catch {
                print(error)
            }
            //SEASONS
            do{
                try db.run(seasons.insertMany([[id <- 14, name <- "2016-2017 Season"], [id <- 20, name <- "2017 Playoffs"], [id <- 22, name <- "2017-2018"], [id <- 28, name <- "2018 Playoffs"],[id <- 29, name <- "2018-2019"], [id <- 33, name <- "2019 Playoffs"], [id <- 34, name <- "2019-2020"], [id <- 37, name <- "2020 Playoffs"], [id <- 40, name <- "2020-2021"]]))
            }
            catch {
                print(error)
            }
            //GAMES
            do{
                try db.run(games.insertMany([
                [id <- 2307, title <- "Crown Room Kings vs Townline Tunnelers", home <- 1371, away <- 1370, homeScore <- 2, awayScore <- 2, date <- "2021-09-10", time <- "03:17:00", location <- 42],
                [id <- 2313, title <- "Atlas Steelers vs Merritt Islanders", home <- 940, away <- 1824, homeScore <- 1, awayScore <- 9, date <- "2021-09-10", time <- "03:17:30", location <- 35],
                [id <- 2316, title <- "Dain City Dusters vs Lincoln Street Legends", home <- 1810, away <- 1822, homeScore <- 3, awayScore <- 1, date <- "2021-09-10", time <- "03:18:00", location <- 30],
                [id <- 2315, title <- "Atlas Steelers vs Lincoln Street Legends", home <- 940, away <- 1822, homeScore <- 2, awayScore <- 1, date <- "2021-09-10", time <- "03:18:30", location <- 15],
                [id <- 2314, title <- "Crown Room Kings vs Lincoln Street Legends", home <- 1371, away <- 1822, homeScore <- 2, awayScore <- 3, date <- "2021-09-10", time <- "03:19:00", location <- 41],
                [id <- 2312, title <- "Merritt Islanders vs Lincoln Street Legends", home <- 1824, away <- 1822, homeScore <- 2, awayScore <- 3, date <- "2021-09-10", time <- "03:19:30", location <- 41],
                [id <- 2311, title <- "Townline Tunnelers vs Lincoln Street Legends", home <- 1370, away <- 1822, homeScore <- 2, awayScore <- 3, date <- "2021-09-10", time <- "03:20:00", location <- 30],
                [id <- 2350, title <- "Atlas Steelers vs Lincoln Street Legends", home <- 940, away <- 1822, homeScore <- 2, awayScore <- 1, date <- "2021-09-10", time <- "03:21:30", location <- 15],
                ]))
            }
            catch {
                print(error)
            }
            //TEAMS
            do{
                try db.run(teams.insertMany([[id <- 940, name <- "Atlas Steelers", slug <- "atlas-steelers", seasonID <- "[33,40,37,43,29,34]"],[id <- 1370, name <- "Townline Tunnelers", slug <- "townline-tunnelers", seasonID <- "[33,40,37,43,29,34]"],[id <- 1371, name <- "Crown Room Kings", slug <- "crown-room-kings", seasonID <- "[33,40,37,43,29,34]"],[id <- 1810, name <- "Dain City Dusters", slug <- "dain-city-dusters", seasonID <- "[40,37,43,34]"],[id <- 1822, name <- "Lincoln Street Legends", slug <- "lincoln-street-legends", seasonID <- "[40,37,43,34]"],[id <- 1824, name <- "Merritt Islanders", slug <- "merritt-islanders", seasonID <- "[40,37,43,34]"]]))
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
}
