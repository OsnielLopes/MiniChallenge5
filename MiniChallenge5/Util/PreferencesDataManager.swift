//
//  PreferencesDataManager.swift
//  MiniChallenge5
//
//  Created by Renan Soares Germano on 06/12/17.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class PreferencesDataManager{
    //MARK: Properties
    private var preferences: [String:Any]!
    private var _isMusicOn: Bool = true
    private var _isSoundOn: Bool = true
    private var _token: String? = nil
    
    //MARK: Getters
    var isMusicOn: Bool {get{return self._isMusicOn}}
    var isSoundOn: Bool {get{return self._isSoundOn}}
    var token: String? {get{return self._token}}
    
    //MARK: Types
    private struct PreferenceKey{
        static let preferences = "preferences"
        static let music = "music"
        static let sound = "sound"
        static let token = "token"
    }
    
    //MARK: Initializers
    init() {
        self.preferences = loadData()
        self._isMusicOn = self.preferences[PreferenceKey.music] as! Bool
        self._isSoundOn = self.preferences[PreferenceKey.sound] as! Bool
        
        if let token = self.preferences[PreferenceKey.token] as? String{
            self._token = token
        }
    }
    
    //MARK: Setters functions
    func changeMusiPreference(){
        self._isMusicOn = !self._isMusicOn
        self.preferences[PreferenceKey.music] = self._isMusicOn
        self.saveData()
    }
    
    func changeSoundPreference(){
        self._isSoundOn = !self._isSoundOn
        self.preferences[PreferenceKey.sound] = self._isSoundOn
        self.saveData()
    }
    
    func saveToken(_ token: String){
        self._token = token
        self.preferences[PreferenceKey.token] = self._token
        self.saveData()
    }
    
    func removeToken(){
        self._token = nil
        self.preferences[PreferenceKey.token] = self._token
        self.saveData()
    }
    
    //MARK: Persistence functions
    private func loadData() -> [String:Any]{
        var defaultPreferences: [String:Any]!
        
        if let preferences = UserDefaults.standard.dictionary(forKey: PreferenceKey.preferences){
            defaultPreferences = preferences
        }else{
            defaultPreferences = [PreferenceKey.music: self._isMusicOn,
                                  PreferenceKey.sound: self._isSoundOn,
                                  PreferenceKey.token: self._token]
        }
        
        return defaultPreferences
    }
    
    private func saveData(){
        UserDefaults.standard.set(self.preferences, forKey: PreferenceKey.preferences)
        UserDefaults.standard.synchronize()
    }
}
