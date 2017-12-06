//
//  PlayerDataManager.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 25/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class PlayerDataManager{
    
    //MARK: Create Player
    func create(name: String, email: String, password: String, factionID: Int, callback: @escaping (_ : Session?) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/player")!
        
        let json: [String:Any] = ["name": name, "email": email, "password":password, "faction_id": factionID]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .sortedKeys)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let session: Session = try decoder.decode(Session.self, from: data)
                    callback(session)
                } catch {
                    print("Impossible to decode to Session from data")
                    callback(nil)
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read all Players
    func read(callback: @escaping (_ : [Player]) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/player")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let players: [Player] = try decoder.decode([Player].self, from: data)
                    callback(players)
                } catch {
                    print("Impossible to decode to Player from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Player by id
    func readById(id: Int, callback: @escaping (_ : Player) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/player/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let player: Player = try decoder.decode(Player.self, from: data)
                    callback(player)
                } catch {
                    print("Impossible to decode to Player from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Player by e-mail
    func readByEmail(email: String, callback: @escaping (_ : Player?) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/player/email/\(email)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let player: Player = try decoder.decode(Player.self, from: data)
                    callback(player)
                } catch {
                    print("Impossible to decode to Player from data")
                    callback(nil)
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Players by Faction
    func readByPlayer(factionID: Int, callback: @escaping (_ : [Player]) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/player/faction/\(factionID)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let players: [Player] = try decoder.decode([Player].self, from: data)
                    callback(players)
                } catch {
                    print("Impossible to decode to Player from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Player by token
    func readByToken(token: String, callback: @escaping (_ : Player?) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/player/token")!
        
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, fromFile: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let player: Player = try decoder.decode(Player.self, from: data)
                    callback(player)
                } catch {
                    print("Impossible to decode to Player from data")
                    callback(nil)
                }
            }
        }
        task.resume()
    }
    
    //MARK: Update Player
    func update(player: Player, callback: @escaping (_ : Player) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner-development.herokuapp.com/player/\(player.id!)")!
            var p = player
            p.id = nil
            let jsonData = try jsonEncoder.encode(p)
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
                    let decoder = JSONDecoder()
                    do {
                        let player: Player = try decoder.decode(Player.self, from: data)
                        callback(player)
                    } catch {
                        print("Impossible to decode to Player from data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Impossible to generate JSON from circuit")
        }
    }
    
    //MARK: Delete Player
    func delete (id: Int, callback: @escaping (_ : Player) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner-development.herokuapp.com/player/\(id)")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
                    let decoder = JSONDecoder()
                    do {
                        let player: Player = try decoder.decode(Player.self, from: data)
                        callback(player)
                    } catch {
                        print("Impossible to decode to Player from data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Impossible to generate JSON from circuit")
        }
    }
    
    //MARK: Login
    func login(email: String, password: String, callback: @escaping (_ : Session?) -> Void){
        do {
            let json: [String:Any] = ["email": email, "password":password]
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .sortedKeys)
            
            let url = URL(string: "https://cyber-runner-development.herokuapp.com/player/login")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    callback(nil)
                    return
                }
                if let data = data{
                    var recievedData: String = String(data: data, encoding: .utf8)!
                    print("***Recieved Data: \(recievedData)***")
                    let decoder = JSONDecoder()
                    do {
                        let session: Session = try decoder.decode(Session.self, from: data)
                        callback(session)
                    } catch {
                        callback(nil)
                        print("Impossible to decode to play from data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Impossible to generate JSON from play")
        }
    }
}
