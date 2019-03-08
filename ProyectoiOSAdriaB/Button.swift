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
    private var textLabel : SKLabelNode = SKLabelNode()
    var startColor : SKColor?
    var highlightColor : SKColor?
    
    
    
    func setText(text: String) {
        //detectar si el parent és null
        //if(textLabel.parent.null){
            textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            textLabel.position = CGPoint(x: frame.width/2.0, y: frame.height/2.0)
        //}
        textLabel.text = text
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //animar per fer un escalat i ferlo més petit
        //fer que canvii de color tamé?
        //fer servir el highlight color per quan comences a fer touch
        if let highlightColor = self.highlightColor {
            self.fillColor = highlightColor;
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //animarlo per fer un escalat i ferlo més gran (potser també mirar si el dit segueix estant al boto o si l'hem mogut)
        //tornarlo a deixar amb el color d'abans?
        //treure el highlightColor i posar el startColor
        
        if let highlightColor = self.highlightColor {
            self.fillColor = highlightColor;
        }
        
        
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
