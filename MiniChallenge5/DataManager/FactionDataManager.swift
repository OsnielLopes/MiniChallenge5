//
//  FactionDataManager.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 24/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class FactionDataManager{
    
    //MARK: Create Faction
    func create (faction: Faction, callback: @escaping (_ : Faction) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(faction)
            let url = URL(string: "https://cyber-runner.herokuapp.com/faction")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
                    let decoder = JSONDecoder()
                    do {
                        let faction: Faction = try decoder.decode(Faction.self, from: data)
                        callback(faction)
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
    
    //MARK: Read all Factions
    func read(callback: @escaping (_ : [Faction]) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/faction")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let factions: [Faction] = try decoder.decode([Faction].self, from: data)
                    callback(factions)
                } catch {
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Fation by id
    func readById(id: Int, callback: @escaping (_ : Faction) -> Void){
        let url = URL(string: "https://cyber-runner.herokuapp.com/faction/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let faction: Faction = try decoder.decode(Faction.self, from: data)
                    callback(faction)
                } catch {
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Update Faction
    func update (faction: Faction, callback: @escaping (_ : Faction) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner.herokuapp.com/faction/\(faction.id!)")!
            var f = faction
            f.id = nil
            let jsonData = try jsonEncoder.encode(f)
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
                        let faction: Faction = try decoder.decode(Faction.self, from: data)
                        callback(faction)
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
    
    //MARK: Delete Faction
    func delete (id: Int, callback: @escaping (_ : Faction) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner.herokuapp.com/faction/\(id)")!
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
                        let faction: Faction = try decoder.decode(Faction.self, from: data)
                        callback(faction)
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
