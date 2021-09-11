//
//  Service.swift
//  WNHL-App
//
//  Created by Sawyer Fenwick on 2021-09-04.
//

import Foundation
import Alamofire    //Network Calls
import SQLite       //Database SQLite Wrapper

/**
 Describes a service for downloading information off the WNHL Wordpress site
 and saves to the local SQLite database
 Build Database is run on first launch
 Update Database is run on subsequent launches
 */
class Service {
    
    fileprivate var baseUrl = ""
    var ids: [Int] = []
    var sluglist: [String] = []
    var playerslist: [String] = []
    var playerIDs: [Int] = []
    var eventIDs: [Int] = []
    
    var topRequests = 5 as Int
    var calendarRequests = 0 as Int
    var eventRequests = 0 as Int
    var playerRequests = 0 as Int
    
    //Path to DB
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    //Shared Preferences
    let sharedPref = UserDefaults.standard
    //Table Column Names
    let id = Expression<Int64?>("id")
    let name = Expression<String?>("name")
    let slug = Expression<String?>("slug")
    let seasonID = Expression<String?>("seasonID")
    let title = Expression<String?>("title")
    let home = Expression<Int64?>("home")
    let away = Expression<Int64?>("away")
    let homeScore = Expression<Int64?>("homeScore")
    let awayScore = Expression<Int64?>("awayScore")
    let date = Expression<String?>("date")
    let time = Expression<String?>("time")
    let location = Expression<Int64?>("location")
    let mediaID = Expression<Int64?>("mediaID")
    let mediaURL = Expression<String?>("mediaURL")
    let content = Expression<String?>("content")
    let leagues = Expression<String?>("leagues")
    let number = Expression<Int64?>("number")
    let prevTeams = Expression<String?>("prevTeams")
    let currTeam = Expression<Int64?>("currTeam")
    let goals = Expression<Int64?>("goals")
    let assists = Expression<Int64?>("assists")
    let points = Expression<Int64?>("points")
    //let stats =
    //let data =
    
    //Table Names
    let venues = Table("Venues")
    let seasons = Table("Seasons")
    let teams = Table("Teams")
    let players = Table("Players")
    let games = Table("Games")
    let standings = Table("Standings")
    
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }//init
    
    /**
     Begins the first 5 network requests
     */
    func buildDatabase() {
        teamRequest(endPoint: "teams/")
        venueRequest(endPoint: "venues/")
        seasonRequest(endPoint: "seasons/")
        statsRequest(endPoint: "lists/1900")
        standingsRequest(endPoint: "tables/")
    }//buildDatabase
    
    /**
     Updates the Games table - only call when there are games coming up
     */
    func updateDatabase(){
        
    }//updateDatabase
    
    /**
     Retrieves the Team Data from the WNHL Wordpress site and inserts it into the DB
     */
    func teamRequest(endPoint: String){
        AF.request(self.baseUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.topRequests-=1
                let teamArray = try JSONDecoder().decode([Teams].self, from: data)
                for teamObj in teamArray {
                    self.sluglist.append(teamObj.slug ?? "")
                    do{
                        let db = try Connection("\(self.path)/wnhl.sqlite3")

                        try db.run(self.teams.insertMany([[self.id <- Int64(teamObj.id ?? 0), self.name <- teamObj.name?["rendered"] ?? "" , self.slug <- teamObj.slug, self.seasonID <- "\(String(describing: teamObj.seasonIDs))"]]))
                    }
                    catch {
                        print("ERROR: " , error)
                    }
                }
            }
            catch{
                print("Error decoding == \(error)")
            }
            if self.topRequests == 0 {
                self.startLowerRequests()
            }
        }
    }//teamRequest
    
    /**
     Retrieves the Venue Data from the WNHL Wordpress site and inserts it into the DB
     */
    func venueRequest(endPoint: String){
        AF.request(self.baseUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.topRequests-=1
                let locations = try JSONDecoder().decode([Venues].self, from: data)
                for place in locations {
                    do{
                        let db = try Connection("\(self.path)/wnhl.sqlite3")
                        
                        try db.run(self.venues.insertMany([[self.id <- Int64(place.id ?? 0), self.name <- String(place.name ?? "")]]))
                    }
                    catch {
                        print("ERROR: " , error)
                    }
                }
            }
            catch{
                print("Error decoding == \(error)")
            }
            if self.topRequests == 0 {
                self.startLowerRequests()
            }
        }
    }//venueRequest
    
    /**
     Retrieves the Seasons Data from the WNHL Wordpress site and inserts it into the DB
     */
    func seasonRequest(endPoint: String){
        AF.request(self.baseUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.topRequests-=1
                let seasonsArray = try JSONDecoder().decode([Seasons].self, from: data)
                for (index,seas) in seasonsArray.enumerated() {
                    do{
                        let db = try Connection("\(self.path)/wnhl.sqlite3")
                        
                        try db.run(self.seasons.insertMany([[self.id <- Int64(seas.id ?? 0), self.name <- String(seas.name ?? "")]]))
                    }
                    catch {
                        print("ERROR: " , error)
                    }
                    if index == seasonsArray.count-2 {
                        self.sharedPref.set(seas.id, forKey: "prevSeason")
                    }
                    if index == seasonsArray.count-1 {
                        self.sharedPref.set(seas.id, forKey: "currSeason")
                    }
                }
            }
            catch{
                print("Error decoding == \(error)")
            }
            if self.topRequests == 0 {
                self.startLowerRequests()
            }
        }
    }//seasonRequest
    
    /**
     Retrieves the List of Players for the current season and stores it in an array for future use
     */
    func statsRequest(endPoint: String){
        AF.request(self.baseUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.topRequests-=1
                let keyArray = try JSONDecoder().decode(PlayerID.self, from: data).data.keys
                for key in keyArray {
                    if Int(key) != 0 {
                        self.playerslist.append(String(key))
                    }
                }
            }
            catch{
                print("Error decoding == \(error)")
            }
            if self.topRequests == 0 {
                self.startLowerRequests()
            }
        }
    }//statsRequest
    
    /**
     Retrieves the Standings Data from the WNHL Wordpress site and inserts it into the DB
     */
    func standingsRequest(endPoint: String){
        AF.request(self.baseUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.topRequests-=1
                let standings = try JSONDecoder().decode([Standings].self, from: data)
                for standing in standings {
                    do{
                        let db = try Connection("\(self.path)/wnhl.sqlite3")
                        try db.run(self.standings.insertMany([[self.id <- Int64(standing.id), self.seasonID <- "\(standing.seasons)"]]))
                    }
                    catch {
                        print("ERROR:", error)
                    }
                }
            }
            catch{
                print("Error decoding == \(error)")
            }
            if self.topRequests == 0 {
                self.startLowerRequests()
            }
        }
    }//standingsRequest
    
    /**
     Downloads the last 2 Tables and inserts them into the database. These tables are reliant on the other tables having
     downloaded first which is why they are "lower requests"
     */
    func startLowerRequests(){
        calendarRequests = sluglist.count
        print("count " , sluglist.count)
        for slug in sluglist {
            createCalendarRequest(endPoint: "calendars?slug="+slug)
        }
        playerRequests = playerslist.count
        print("Player Requests: " , playerRequests)
        for pid in playerslist {
            getPlayer(endPoint: "players/" , pid: pid)
        }
    }//startLowerRequests
    
    /**
     Retrieves the List of Events  for the current season and stores it in an array for future use
     */
    func createCalendarRequest(endPoint: String){
        AF.request(self.baseUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.calendarRequests-=1
                let games = try JSONDecoder().decode([Games].self, from: data)
                if games.count != 0 {
                    let array = games[0].data
                    for arr in array {
                        if self.eventIDs.contains(arr.ID) {
                            //do nothing
                        }
                        else {
                            self.eventIDs.append(arr.ID)
                        }
                    }
                }
            }
            catch{
                print("Error DECODING == \(error)")
            }
            if self.calendarRequests == 0 {
                self.eventRequests = self.eventIDs.count
                for e in self.eventIDs {
                    self.getEvent(endPoint: "events/" , eid: e)
                }
            }
        }
    }//createCalendarsRequest
    
    /**
     Downloads a single games data from the WNHL Wordpress site and inserts it into the Games table
     */
    func getEvent(endPoint: String, eid: Int){
        AF.request(self.baseUrl+endPoint+String(eid), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.eventRequests-=1
                let game = try JSONDecoder().decode(Game.self, from: data)
                let db = try Connection("\(self.path)/wnhl.sqlite3")
                
                let dateArray = game.date.components(separatedBy: "T")
                
                let dateString = dateArray[0]
                let timeString = dateArray[1]
                
                var hScore = 0 as Int64
                var aScore = 0 as Int64
                var ven = 0 as Int64
                
                if game.results.isEmpty {
                    hScore = -1
                    aScore = -1
                }
                else{
                    hScore = Int64(game.results[0]) ?? -1
                    aScore = Int64(game.results[1]) ?? -1
                }
                
                if game.venues.isEmpty {
                    ven = -1
                }
                else{
                    ven = Int64(game.venues[0])
                }
                
                try db.run(self.games.insertMany([[self.id <- Int64(game.id), self.title <- game.title["rendered"], self.home <- Int64(game.teams[0]) , self.away <- Int64(game.teams[1]) , self.homeScore <- hScore , self.awayScore <- aScore , self.date <- dateString, self.time <- timeString , self.location <- ven]]))
            }
            catch{
                print("ERROR DECODING!!! == \(error)")
            }
            if self.eventRequests == 0 && self.playerRequests == 0 {
                print("DONE")
                //THIS IS WHERE WE WILL SET SOMETHING THAT TELLS THE MAIN VIEW CONTROLLER TO
                //STOP SHOWING THE SPLASH SCREEN AND MOVE TO THE SCHEDULE VIEW
            }
        }
    }//getEvent
    
    /**
     Downloads a single Player object from the WNHL Wordpress site and inserts it into the Players Table
     */
    func getPlayer(endPoint: String, pid: String){
        var points: Int64?
        var assists: Int64?
        var goals: Int64?
        let currSeason = self.sharedPref.integer(forKey: "currSeason")
        let prevSeason = self.sharedPref.integer(forKey: "prevSeason")
        AF.request(self.baseUrl+endPoint+pid, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response {
            (responseData) in
            guard let data = responseData.data else{
                return
            }
            do {
                self.playerRequests-=1
                let db = try Connection("\(self.path)/wnhl.sqlite3")
                let player = try JSONDecoder().decode(Players.self, from: data)
                
                //Get Points and Assists and Goals before inserting into DB
                if player.statistics?.three?[String(currSeason)]?.p == nil {
                    points = Int64(player.statistics?.three?[String(prevSeason)]?.p ?? "0")
                }
                else{
                    points = Int64(player.statistics?.three?[String(currSeason)]?.p ?? "0")
                }
                if player.statistics?.three?[String(currSeason)]?.g == nil {
                    goals = Int64(player.statistics?.three?[String(prevSeason)]?.g ?? 0)
                }
                else{
                    goals = Int64(player.statistics?.three?[String(currSeason)]?.g ?? 0)
                }
                if player.statistics?.three?[String(currSeason)]?.a == nil {
                    assists = Int64(player.statistics?.three?[String(prevSeason)]?.a ?? 0)
                }
                else{
                    assists = Int64(player.statistics?.three?[String(currSeason)]?.a ?? 0)
                }
                
                try db.run(self.players.insertMany([[self.id <- Int64(player.id ?? 0), self.name <- String(player.name?["rendered"] ?? ""), self.content <- player.content?.rendered, self.seasonID <- "\(String(describing: player.seasons))", self.number <- Int64(player.number ?? -1), self.currTeam <- Int64(player.team?[0] ?? -1), self.goals <- goals, self.assists <- assists, self.points <- points, self.mediaID <- Int64(player.media ?? 0)]]))

            }
            catch{
                print("Error decoding == \(error)")
            }
            if self.eventRequests == 0 && self.playerRequests == 0 {
                print("DONE")
                //THIS IS WHERE WE WILL SET SOMETHING THAT TELLS THE MAIN VIEW CONTROLLER TO
                //STOP SHOWING THE SPLASH SCREEN AND MOVE TO THE SCHEDULE VIEW
            }
        }
    }//getPlayer
    
    func addNewGame(){
        do {
            let db = try Connection("\(self.path)/wnhl.sqlite3")
            
            try db.run(self.games.insertMany([[self.id <- 10000, self.title <- "test game vs test game", self.home <- 940 , self.away <- 940 , self.homeScore <- 0 , self.awayScore <- 0 , self.date <- "2021-09-30", self.time <- "20:30:00" , self.location <- 42]]))
        }
        catch {
            print(error)
        }
        
    }
}
