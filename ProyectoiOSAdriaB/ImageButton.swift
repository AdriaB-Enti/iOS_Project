//
//  ImageButton.swift
//  ProyectoiOSAdriaB
//
//  Created by Entipro on 2019/5/23.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation
import SpriteKit

class ImageButton: Button{
    var buttonImage: SKSpriteNode?
    
    func setImage(image: String){
        buttonImage = SKSpriteNode(imageNamed: image)
        if let button = buttonImage{
            button.size = CGSize(width: self.frame.width, height: self.frame.height)
            button.position.x += button.frame.width/2.0
            button.position.y += button.frame.height/2.0
            self.addChild(button)
        }
    }
    
    
    
}
