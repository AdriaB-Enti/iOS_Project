//
//  MenuScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 7/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol MenuSceneDelegate: class {
    func goToAbout(sender: MenuScene)
    func goToGame(sender: MenuScene)
}

class MenuScene: SKScene, ButtonDelegate {
    
    private var label : SKLabelNode?
    
    weak var menuDelegate: MenuSceneDelegate?
    
    var logo :SKSpriteNode?
    
    //MENU BUTTONS
    private var startButton = Button(rect: CGRect(x: 0, y: 0, width: 300, height: 100), cornerRadius: 15)
    
    private var optionsButton = Button(rect: CGRect(x: 0, y: 0, width: 70, height: 70), cornerRadius: 30)

    private var aboutButton = Button(rect: CGRect(x: 0, y: 0, width: 240, height: 90), cornerRadius: 15)

    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(named: "myBlue")!
        //Button init
        startButton.fillColor = UIColor(named: "myOrange")!
        startButton.position = CGPoint(x: (view.frame.width/2.0) - startButton.frame.width/2.0, y: (1.1*view.frame.height / 3.0) - startButton.frame.height/2.0)
        startButton.isUserInteractionEnabled = true  //activate events
        startButton.delegate = self
        startButton.setText(text: "Play")
        startButton.setTextColor(color: .black)
        addChild(startButton)
        
        optionsButton.fillColor = UIColor(named: "myGray")!
        optionsButton.position = CGPoint(x: (8.75*view.frame.width/10.0) - optionsButton.frame.width/2.0, y: (9.5*view.frame.height / 10.0) - optionsButton.frame.height/2.0)
        optionsButton.isUserInteractionEnabled = true
        optionsButton.delegate = self
        optionsButton.setTextColor(color: .black)
        addChild(optionsButton)
        
        aboutButton.fillColor = UIColor(named: "myOrange")!
        aboutButton.position = CGPoint(x: (view.frame.width/2.0) - aboutButton.frame.width/2.0, y: (view.frame.height / 5.0) - aboutButton.frame.height/2.0)
        aboutButton.isUserInteractionEnabled = true
        aboutButton.delegate = self
        aboutButton.setText(text: "About")
        aboutButton.setTextColor(color: .black)
        aboutButton.delegate = self
        addChild(aboutButton)
        
        if var logo = self.logo{
            logo =  SKSpriteNode(imageNamed: "pica")
            logo.position = CGPoint(x: view.frame.width/2,y: view.frame.height/2)
            addChild(logo)
        }
        
        // Get label node from scene and store it for use later
        
        self.label = SKLabelNode(text:"Magic Memorizer")
                
        //self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            //label.alpha = 0.0
            addChild(label)
            label.fontName = "HeroesLegend"
            label.fontColor = UIColor(named: "SecondOrange")!
            
            label.fontSize = 29
            label.position = CGPoint(x: view.frame.width/2.0, y: 4.5 * view.frame.height / 7.0)
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
    }
    
    func onTap(sender: Button) {
        if(sender == startButton){
            menuDelegate?.goToGame(sender: self)
            
        }
        if(sender == optionsButton){
            
        }
        
        if(sender == aboutButton){
            menuDelegate?.goToAbout(sender: self)
        }
    }
}
