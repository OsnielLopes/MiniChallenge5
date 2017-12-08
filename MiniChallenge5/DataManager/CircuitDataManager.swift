//
//  CircuitDataManager.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 26/11/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class CircuitDataManager : CircuitDataManagerProtocol{
    
    func getCircuitLocations(callback: @escaping ([Int : Location]) -> ()) {
        var locations: [Int:Location] = [Int:Location]()
        self.read(callback: {circuits in
            circuits.forEach({circuit in
                locations[circuit.id!] = circuit.location
            })
            callback(locations)
        })
    }
    
    //MARK: Create Circuit
    func create(circuit: Circuit, callback: @escaping (_ : Circuit) -> Void){
//        print("\n\n***CREATE***")
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(circuit)
            
//            print("\n\n***Encoded Data!***")
//            print(String.init(data: jsonData, encoding: .utf8))
            
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
//                    let recievedData = String.init(data: self.clearData(data: data), encoding: .utf8)!
//                    print("***Recieved data!***")
//                    print(recievedData)
                    
                    let decoder = JSONDecoder()
                    do {
                        let circuit: Circuit = try decoder.decode(Circuit.self, from: self.clearData(data: self.clearData(data: data)))
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
//        print("\n\n***READ***")
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/circuit")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
//                let recievedData = String.init(data: self.clearData(data: data), encoding: .utf8)!
//                print("***Recieved data!***")
//                print(recievedData)
                
                let decoder = JSONDecoder()
                do {
                    let circuits: [Circuit] = try decoder.decode([Circuit].self, from: self.clearData(data: data))
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
//        print("\n\n***READ BY ID***")
        let url = URL(string: "https://cyber-runner-development.herokuapp.com/circuit/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data{
//                let recievedData = String.init(data: self.clearData(data: data), encoding: .utf8)!
//                print("***Recieved data!***")
//                print(recievedData)
                
                let decoder = JSONDecoder()
                do {
                    let circuit: Circuit = try decoder.decode(Circuit.self, from: self.clearData(data: data))
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
//        print("\n\n***DELETE***")
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
//                    let recievedData = String.init(data: self.clearData(data: data), encoding: .utf8)!
//                    print("***Recieved data!***")
//                    print(recievedData)
                    
                    let decoder = JSONDecoder()
                    do {
                        let circuit: Circuit = try decoder.decode(Circuit.self, from: self.clearData(data: data))
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
    
    //MARK: Aux funcs
    private func clearData(data: Data) -> Data{
        let recievedData: String = String(data: data, encoding: .utf8)!
            .replacingOccurrences(of: "\"m00\":\"", with: "\"m00\":")
            .replacingOccurrences(of: "\"m01\":\"", with: "\"m01\":")
            .replacingOccurrences(of: "\"m02\":\"", with: "\"m02\":")
            .replacingOccurrences(of: "\"m03\":\"", with: "\"m03\":")
            .replacingOccurrences(of: "\"m10\":\"", with: "\"m10\":")
            .replacingOccurrences(of: "\"m11\":\"", with: "\"m11\":")
            .replacingOccurrences(of: "\"m12\":\"", with: "\"m12\":")
            .replacingOccurrences(of: "\"m13\":\"", with: "\"m13\":")
            .replacingOccurrences(of: "\"m20\":\"", with: "\"m20\":")
            .replacingOccurrences(of: "\"m21\":\"", with: "\"m21\":")
            .replacingOccurrences(of: "\"m22\":\"", with: "\"m22\":")
            .replacingOccurrences(of: "\"m23\":\"", with: "\"m23\":")
            .replacingOccurrences(of: "\"m30\":\"", with: "\"m30\":")
            .replacingOccurrences(of: "\"m31\":\"", with: "\"m31\":")
            .replacingOccurrences(of: "\"m32\":\"", with: "\"m32\":")
            .replacingOccurrences(of: "\"m33\":\"", with: "\"m33\":")
            .replacingOccurrences(of: "\",\"m", with: ",\"m")
            .replacingOccurrences(of: "\"}]", with: "}]")
            .replacingOccurrences(of: "\"},{\"m", with: "},{\"m")
            .replacingOccurrences(of: "\"magnetic_heading\":\"", with: "\"magnetic_heading\":")
            .replacingOccurrences(of: "\",\"magnetic_heading", with: ",\"magnetic_heading")
            .replacingOccurrences(of: "\"magnetic_heading\":\"", with: "\"magnetic_heading\":")
            .replacingOccurrences(of: "\",\"latitude", with: ",\"latitude")
            .replacingOccurrences(of: "latitude\":\"", with: "latitude\":")
            .replacingOccurrences(of: "\",\"longitude", with: ",\"longitude")
            .replacingOccurrences(of: "longitude\":\"", with: "longitude\":")
            .replacingOccurrences(of: "\",\"bow", with: ",\"bow")
            .replacingOccurrences(of: "accuracy\":\"", with: "accuracy\":")
        return recievedData.data(using: .utf8)!
    }
}
