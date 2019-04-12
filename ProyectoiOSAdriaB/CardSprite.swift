//
//  CardSprite.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 21/03/2019.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//


import SpriteKit

protocol CardDelegate: class {
    func onCardTap(sender: CardSprite)
}

class CardSprite : SKSpriteNode{
    //afegir un Card
    var cardID:Int = 0
    weak var delegate: CardDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let action = SKAction.scale(by: -1, duration: 0.2)
        //run(action)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //animarlo per fer un escalat i ferlo més gran (potser també mirar si el dit segueix estant al boto o si l'hem mogut)
        //let action = SKAction.scale(by: 1.0, duration: 0.2)
        //run(action)
        
        //check if the user still has the finger inside the button
        if let touch = touches.first, let parent = parent {
            if frame.contains(touch.location(in: parent)){
                if let delegate = delegate {
                    delegate.onCardTap(sender: self)
                }
            }
        }
    }
}
