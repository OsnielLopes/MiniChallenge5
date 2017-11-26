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
    func create(player: Player, callback: @escaping (_ : Player) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(player)
            
//            print("Encoded Data: \(String(data: jsonData, encoding: .utf8))")
            let url = URL(string: "https://cyber-runner.herokuapp.com/player")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
//                let httpResponse = response as! HTTPURLResponse
//                print("Request Status Code: \(httpResponse.statusCode)")
                if let data = data{
                    let decoder = JSONDecoder()
                    do {
                        let player: Player = try decoder.decode(Player.self, from: data)
                        callback(player)
                    } catch {
                        print("Impossible to decode to player from data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Impossible to generate JSON from circuit")
        }
    }
    
    //MARK: Read all Players
    func read(callback: @escaping (_ : [Player]) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/player")!
        
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
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Player by id
    func readById(id: Int, callback: @escaping (_ : Player) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/player/\(id)")!
        
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
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Update Player
    func update(player: Player, callback: @escaping (_ : Player) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner.herokuapp.com/player/\(player.id!)")!
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
                        print("Impossible to decode to Faction from data")
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
            let url = URL(string: "https://cyber-runner.herokuapp.com/player/\(id)")!
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
                        print("Impossible to decode to Faction from data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Impossible to generate JSON from circuit")
        }
    }
}
