//
//  Button.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 7/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//
import SpriteKit


protocol ButtonDelegate: class {
    func onTap(sender: Button)
}

class Button: SKShapeNode{
    
    weak var delegate: ButtonDelegate?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //check if the user still has the finger inside the button
        if let touch = touches.first, let parent = parent {
            if frame.contains(touch.location(in: parent)){
                if let delegate = delegate {
                    delegate.onTap(sender: self)
                }
                
                print("button touched")
            }
        }
    }
    
    
    
    
}
