//
//  Preferences.swift
//  ProyectoiOSAdriaB
//
//  Created by Entipro on 2019/4/25.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation

class Preferences {
    
    func getUserID()-> String {
        let defaults = UserDefaults.standard
        
        var userId = defaults.string(forKey: "userId") ?? ""
        
        print("userId")
        if(userId.isEmpty){
            userId = UUID().uuidString
            defaults.set(userId,forKey: "userId" )
        }
        print(userId)
        
        return userId
        //4CB1EA65-4DE9-4F56-AAB1-522B90A13A77
    }
    
    //Music
    func getMusicEnabled()-> Bool{
        let defaults = UserDefaults.standard
        
        let musicEnabled = defaults.bool(forKey: "musicEnabled")
        
        return musicEnabled
    }
    
    func toggleMusic(){
        let defaults = UserDefaults.standard
        let musicEnabled = defaults.bool(forKey: "musicEnabled")
        defaults.set(!musicEnabled,forKey: "musicEnabled" )
    }
    
    func setMusicEnabled(isEnabled:Bool){
        let defaults = UserDefaults.standard
        defaults.set(isEnabled,forKey: "musicEnabled" )
    }
    
    func setDefaultLevel(level:Level){
        UserDefaults.standard.set(level.rawValue, forKey: "level")
    }
    
    func getDefaultLevel()->Level{
        let defaults = UserDefaults.standard
        let level:Level = Level(rawValue:(defaults.integer(forKey: "level"))) ?? Level.easy
        
        return level
    }
    
    func saveUserName(name:String){
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "username")
    }
    
    func getUsername()->String{
        return UserDefaults.standard.string(forKey: "username") ?? "usernamNotSet"
    }
    
}
