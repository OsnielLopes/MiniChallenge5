//
//  PlayDataManager.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 30/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class PlayDataManager{
    //MARK: Create Play
    func create(play: Play, callback: @escaping (_ : Play) ->Void){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(play)
            let url = URL(string: "https://cyber-runner.herokuapp.com/play")!
            var request = URLRequest(url: url)
            request.addValue(Session.shared?.token ?? "", forHTTPHeaderField: "x-access-token")
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
//                    var recievedData: String = String(data: data, encoding: .utf8)!
//                    print("***Recieved Data: \(recievedData)***")
                    let decoder = JSONDecoder()
                    do {
                        let play: Play = try decoder.decode(Play.self, from: data)
                        callback(play)
                    } catch {
                        print("Impossible to decode to play from data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Impossible to generate JSON from play")
        }
    }
    
    //MARK: Read all Plays
    func read(callback: @escaping (_ : [Play]) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/play")!
        
        var request = URLRequest(url: url)
        request.addValue(Session.shared?.token ?? "", forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, fromFile: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let plays: [Play] = try decoder.decode([Play].self, from: data)
                    callback(plays)
                } catch {
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Play by id
    func readById(id: Int, callback: @escaping (_ : Play) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/play/\(id)")!
        
        var request = URLRequest(url: url)
        request.addValue(Session.shared?.token ?? "", forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, fromFile: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let play: Play = try decoder.decode(Play.self, from: data)
                    callback(play)
                } catch {
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Plays by Player
    func readByPlayer(playerID: Int, callback: @escaping (_ : [Play]) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/play/player/\(playerID)")!
        
        var request = URLRequest(url: url)
        request.addValue(Session.shared?.token ?? "", forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, fromFile: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let plays: [Play] = try decoder.decode([Play].self, from: data)
                    callback(plays)
                } catch {
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Plays by Circuit
    func readByCircuit(circuitID: Int, callback: @escaping (_ : [Play]) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/play/circuit/\(circuitID)")!
        
        var request = URLRequest(url: url)
        request.addValue(Session.shared?.token ?? "", forHTTPHeaderField: "x-access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, fromFile: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let plays: [Play] = try decoder.decode([Play].self, from: data)
                    callback(plays)
                } catch {
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Update Play
    func update(play: Play, callback: @escaping (_ : Play) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner.herokuapp.com/play/\(play.id!)")!
            var p = play
            p.id = nil
            let jsonData = try jsonEncoder.encode(p)
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(Session.shared?.token ?? "", forHTTPHeaderField: "x-access-token")
            
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
                    let decoder = JSONDecoder()
                    do {
                        let play: Play = try decoder.decode(Play.self, from: data)
                        callback(play)
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
    
    //MARK: Delete Play
    func delete(id: Int, callback: @escaping (_ : Play) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner.herokuapp.com/play/\(id)")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.addValue(Session.shared?.token ?? "", forHTTPHeaderField: "x-access-token")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
                    let decoder = JSONDecoder()
                    do {
                        let play: Play = try decoder.decode(Play.self, from: data)
                        callback(play)
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
