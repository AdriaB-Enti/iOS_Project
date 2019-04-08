//
//  Card.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 21/03/2019.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation

enum CardState: Int {
    case facingDown
    case facingUp
    case matched
}

class Card{
    var id = 0
    var pairId = 0
    var textureFront = ""
    var textureBack = "CardBack"
    var state = CardState.facingDown
    
    init(_ id:Int, _ pairId:Int, _ textureFront:String){
        self.id = id
        self.pairId = pairId
        self.textureFront = textureFront
    }
    init(){
        
    }
}
