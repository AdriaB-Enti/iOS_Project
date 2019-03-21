//
//  Card.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 21/03/2019.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation

class Card{
    var id = 0
    var textureFront = ""
    var textureBack = "backTexture"
    
    init(_ id:Int, _ textureFront:String){
        self.id = id
        self.textureFront = textureFront
    }
    
    
}
