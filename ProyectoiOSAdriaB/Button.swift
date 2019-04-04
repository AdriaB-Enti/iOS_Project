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
    private var textLabel : SKLabelNode = SKLabelNode(fontNamed: "HeroesLegend")
    var startColor : SKColor?
    var highlightColor : SKColor = SKColor.white
    
    
    func setText(text: String) {
        //detectar si el parent és null
        if(textLabel.parent == nil){
            addChild(textLabel)
            //textLabel.fontName = "HeroesLegend"
            textLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            textLabel.position = CGPoint(x: frame.width/2.0, y: frame.height/2.0)
        }
        textLabel.text = text
        
    }
    
    func setTextColor(color : UIColor){
        textLabel.fontColor = color
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.scale(by: 0.9, duration: 0.1)
        run(action)
        //if let highlightColor = self.highlightColor {
            self.startColor = self.fillColor
            self.fillColor = self.highlightColor;
        //}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //animarlo per fer un escalat i ferlo més gran (potser també mirar si el dit segueix estant al boto o si l'hem mogut)
        let action = SKAction.scale(by: 1.0/0.9, duration: 0.1)
        run(action)
        //if let highlightColor = self.highlightColor {
            if let startColor = self.startColor {
                self.fillColor = startColor;
            }
        //}
        
        
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
