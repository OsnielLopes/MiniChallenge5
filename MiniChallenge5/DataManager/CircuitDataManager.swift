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
        //TODO: implementar esse método
    }
    
    //MARK: Create Circuit
    func create(circuit: Circuit, callback: @escaping (_ : Circuit) -> Void){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(circuit)
            let url = URL(string: "https://cyber-runner.herokuapp.com/circuit")!
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
                        let circuit: Circuit = try decoder.decode(Circuit.self, from: data)
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
        
    }
    
    //MARK: Read Circuit by id
    func readById(id: Int, callback: @escaping (_ : Circuit) -> Void){
        
    }
    
    //MARK: Update Circuit
//    func update(circuit: Circuit, callback: @escaping (_ : Circuit) -> Void){
//        
//    }
    
    //MARK: Delete Circuit
    func delete (id: Int, callback: @escaping (_ : Circuit) -> Void){
        
    }
}
