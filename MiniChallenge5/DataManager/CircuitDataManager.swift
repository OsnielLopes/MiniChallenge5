//
//  CircuitDataManager.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class CircuitDataManager : CircuitDataManagerProtocol{
    func getCircuitLocations(callback: @escaping ([Bow]) -> ()) {
        var firstBows: [Bow] = [Bow]()
        self.read {
            $0.forEach{
                firstBows.append($0.bows.first!)
            }
            callback(firstBows)
        }
    }
    
    //MARK: Create Circuit
    func create(circuit: Circuit, callback: @escaping (_ : Circuit) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(circuit)
            let url = URL(string: "https://cyber-runner-development.herokuapp.com/circuit")!
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
                        let circuit: Circuit = try decoder.decode(Circuit.self, from: self.clean(data: data))
                        callback(circuit)
                    } catch {
                        print("Impossible to decode to circuit from data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Impossible to generate JSON from circuit")
        }
    }
    
    //MARK: Read all Circuits
    func read(callback: @escaping (_ : [Circuit]) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/circuit")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let circuits: [Circuit] = try decoder.decode([Circuit].self, from: self.clean(data: data))
                    callback(circuits)
                } catch {
                    print("Impossible to decode to Circuit from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Read Circuit by id
    func readById(id: Int, callback: @escaping (_ : Circuit) -> Void){
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/circuit/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let circuit: Circuit = try decoder.decode(Circuit.self, from: self.clean(data: data))
                    callback(circuit)
                } catch {
                    print("Impossible to decode to Faction from data")
                }
            }
        }
        task.resume()
    }
    
    //MARK: Update Circuit
    //    func update(circuit: Circuit, callback: @escaping (_ : Circuit) -> Void){
    //
    //    }
    
    //MARK: Delete Circuit
    func delete (id: Int, callback: @escaping (_ : Circuit) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let url = URL(string: "https://cyber-runner-development.herokuapp.com/circuit/\(id)")!
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
                        let circuit: Circuit = try decoder.decode(Circuit.self, from: self.clean(data: data))
                        callback(circuit)
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
    
    //MAKR: Aux funcs
    private func clean(data: Data) -> Data{
        var recievedData: String = String(data: data, encoding: .utf8)!
        if recievedData.contains("circuit_id"){
            recievedData = recievedData.replacingOccurrences(of: "\"latitude\":\"", with: "\"latitude\":")
                .replacingOccurrences(of: "\",\"longitude\":\"", with: ",\"longitude\":")
                .replacingOccurrences(of: "\",\"circuit_id\"", with: ",\"circuit_id\"")
        }else{
            recievedData = recievedData.replacingOccurrences(of: ":[{\"latitude\":\"", with: ":[{\"latitude\":")
                .replacingOccurrences(of: "\"},{\"latitude\":\"", with: "},{\"latitude\":")
                .replacingOccurrences(of: "\",\"longitude\":\"", with: ",\"longitude\":")
                .replacingOccurrences(of: "\"}],\"id\":", with: "}],\"id\":")
                .replacingOccurrences(of: "\"}]}", with: "}]}")
        }
        return recievedData.data(using: .utf8)!
    }
}
