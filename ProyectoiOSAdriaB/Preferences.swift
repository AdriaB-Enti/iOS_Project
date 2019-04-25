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
}
