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
        let playerDataManager: PlayerDataManager = PlayerDataManager()
        let factionDatamanager: FactionDataManager = FactionDataManager()
        
//        factionDatamanager.readById(id: 3, callback: {
//            let player: Player = Player(id: nil, name: "Renan Soares Germano", email: "renan.rsg@hotmail.com", password: "abcdef", faction: $0)
//            playerDataManager.create(player: player, callback: {
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
        var circuit: Circuit = Circuit()
//        circuit.bows.append(Bow(latitude: 10, longitude: 20))
//        circuit.bows.append(Bow(latitude: 30, longitude: 50))
//        circuit.bows.append(Bow(latitude: 60, longitude: 70))
//        circuit.bows.append(Bow(latitude: 80, longitude: 90))
//        circuit.bows.append(Bow(latitude: 100, longitude: 110))
        
        circuitDataManager.create(circuit: circuit, callback: {
            print("***Created Circuit: \($0)***")
            var newCircuit = $0
            
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
