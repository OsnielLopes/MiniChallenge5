//
//  DataManagerTest.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 02/12/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class DataManagerTest{
    
    
    func testFactionDataManager(){
        let factionDataManager: FactionDataManager = FactionDataManager()
        
        factionDataManager.create(faction: Faction.init(id: nil, name: "Teste"), callback: {
            print("***Created faction: \($0)***")
            
            factionDataManager.read(callback: {
                print("***\nFactions***")
                $0.forEach({print($0)})
                
                factionDataManager.readById(id: 6, callback: {
                    print("***\nFaction: \($0)***")
                    var faction = $0
                    faction.name = "Alterada!"
                    
                    factionDataManager.update(faction: faction, callback: {
                        print("***\nUpdated Faction: \($0)***")
                        
                        factionDataManager.delete(id: $0.id!, callback: {
                            print("***\nDeleted Faction: \($0)***")
                        })
                    })
                })
            })
        })
    }
    
    func testPlayerDataManager(){
//        let playerDataManager: PlayerDataManager = PlayerDataManager()
//        let factionDatamanager: FactionDataManager = FactionDataManager()
//        
//        factionDatamanager.readById(id: 3, callback: {
//            let player: Player = Player(id: nil, name: "Renan Soares Germano", email: "renan.rsg@hotmail.com", password: "abcdef", faction: $0)
//            
//            playerDataManager.create(name: player.name, email: player.email!, password: "12345678", factionID: 2,  callback: {
//                print("***Created Session: \($0!)***")
//                var createdSession = $0!
//                Session.shared = createdSession
//
//                playerDataManager.read(callback: {
//                    print("\n***All Players***")
//                    $0.forEach({
//                        print($0)
//                    })
//
//                    playerDataManager.readById(id: (Session.shared?.player.id!)!, callback: {
//                        print("\n***Player: \($0)***")
//                        
//                        createdPlayer.name = "NOME ALTERADO!"
//                        playerDataManager.update(player: Session.shared?.player, callback: {
//                            print("\n***Updated Player: \($0)***")
//                            
//                            playerDataManager.delete(id: $0.id!, callback: {
//                                print("\n***Deleted Player: \($0)***")
//                                
//                                playerDataManager.readByEmail(email: "renan@email.com", callback: {
//                                    print("\n***Player By E-mail: \($0)")
//                                    
//                                    playerDataManager.readByFaction(factionID: 2, callback: {
//                                        print("\n***Players By Faction***")
//                                        $0.forEach({print($0)})
//                                    })
//                                })
//                            })
//                        })
//                    })
//                })
//            })
//        })
    }
    
    func testCircuitDataManager(){
        let circuitDataManager: CircuitDataManager = CircuitDataManager()
        print("***CIRCUIT LOCATIONS***")
        circuitDataManager.getCircuitLocations(callback: {locations in
            locations.forEach({location in
                print("Circuit: \(location.key) - Location: \(location.value)")
            })
        })
        
        
        var circuit: Circuit = Circuit()
        let location: Location = Location(accuracy: 10, magneticHeading: 10, latitude: 10, longitude: 10)
        var m: [[Float]] = [[Float]]()
        m.append([10,20,30,40])
        m.append([50, 60,70,80])
        m.append([90,100,110,120])
        m.append([130,140,150,160])
        var b1: Bow = Bow(); b1.worldTransform = m
        var b2: Bow = Bow(); b2.worldTransform = m
        var b3: Bow = Bow(); b3.worldTransform = m
        circuit.location = location
        circuit.bows = [b1, b2, b3]
        
        circuitDataManager.create(circuit: circuit, callback: {
            print("***Created Circuit: \($0)***")
            let newCircuit = $0
            
            circuitDataManager.read(callback: {
                print("\n***Circuits***")
                $0.forEach({print($0)})
                
                circuitDataManager.readById(id: newCircuit.id!, callback: {
                    print("\n***Circuit***")
                    print($0)
                    
                    circuitDataManager.delete(id: $0.id!, callback: {
                        print("\n***Deleted Circuit: \($0)***")
                    })
                })
            })
        })
        
    }
    
    func testPlayDataManager(){
        let playDataManager: PlayDataManager = PlayDataManager()
        let playerDatamanager: PlayerDataManager = PlayerDataManager()
        let circuitDataManager: CircuitDataManager = CircuitDataManager()
        
        playerDatamanager.readById(id: 1, callback: {
            let player = $0
            circuitDataManager.readById(id: 1, callback: {
                var circuit = $0
                let play: Play = Play(id: nil, circuitID: circuit.id!, player: player, seconds: 333, milliseconds: 303)
                
                playDataManager.create(play: play, callback: {
                    print("***Created Play: \($0)***")
                    var newPlay = $0
                    
                    playDataManager.read(callback: {
                        print("\n***Plays***")
                        $0.forEach({print($0)})
                        
                        playDataManager.readById(id: newPlay.id!, callback: {
                            print("\n***Play***")
                            print($0)
                            
                            playDataManager.readByPlayer(playerID: player.id!, callback: {
                                print("\n***Plays by Player***")
                                $0.forEach({print($0)})
                                
                                playDataManager.readByCircuit(circuitID: circuit.id!, callback: {
                                    print("\n***Plays by Circuit***")
                                    $0.forEach({print($0)})
                                    
                                    newPlay.seconds = 9
                                    newPlay.milliseconds = 333
                                    playDataManager.update(play: newPlay, callback: {
                                        print("\n***Updated Play***")
                                        print($0)
                                        
                                        playDataManager.delete(id: newPlay.id!, callback: {
                                            print("\n***Deleted Play***")
                                            print($0)
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
    }
    
}
