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
    
    //private var optionsButton = Button(rect: CGRect(x: 0, y: 0, width: 70, height: 70), cornerRadius: 30)

    private var aboutButton = Button(rect: CGRect(x: 0, y: 0, width: 230, height: 80), cornerRadius: 15)
    let easyButton = Button(rect: CGRect(x: 0, y: 0, width: 160, height: 67), cornerRadius: 15)
    let mediumButton = Button(rect: CGRect(x: 0, y: 0, width: 160, height: 67), cornerRadius: 15)
    let hardButton = Button(rect: CGRect(x: 0, y: 0, width: 160, height: 67), cornerRadius: 15)
    
    var selectedDif = Level.easy
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(named: "myBlue")!
        //Button init
        startButton.fillColor = UIColor(named: "myOrange")!
        startButton.position = CGPoint(x: (view.frame.width/2.0) - startButton.frame.width/2.0, y: (1.35*view.frame.height / 3.0) - startButton.frame.height/2.0)
        startButton.isUserInteractionEnabled = true  //activate events
        startButton.delegate = self
        startButton.setText(text: "Play")
        startButton.setTextColor(color: .black)
        addChild(startButton)
        
        /*optionsButton.fillColor = UIColor(named: "myGray")!
        optionsButton.position = CGPoint(x: (8.75*view.frame.width/10.0) - optionsButton.frame.width/2.0, y: (9.5*view.frame.height / 10.0) - optionsButton.frame.height/2.0)
        optionsButton.isUserInteractionEnabled = true
        optionsButton.delegate = self
        optionsButton.setTextColor(color: .black)
        addChild(optionsButton)*/
        
        aboutButton.fillColor = UIColor(named: "myOrange")!
        aboutButton.position = CGPoint(x: (view.frame.width/2.0) - aboutButton.frame.width/2.0, y: (view.frame.height / 5.5) - aboutButton.frame.height/2.0)
        aboutButton.isUserInteractionEnabled = true
        aboutButton.delegate = self
        aboutButton.setText(text: "About")
        aboutButton.setTextColor(color: .black)
        addChild(aboutButton)
        
        /*logo =  SKSpriteNode(imageNamed: "testicon")
        if var logo = self.logo{
            logo.position = CGPoint(x: view.frame.width/2,y: view.frame.height/2)
            addChild(logo)
        }*/
        
        // Get label node from scene and store it for use later
        
        self.label = SKLabelNode(text:"Magic Memorizer")
                
        //self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            //label.alpha = 0.0
            addChild(label)
            label.fontName = "HeroesLegend"
            label.fontColor = UIColor(named: "SecondOrange")!
            
            label.fontSize = 35
            label.position = CGPoint(x: view.frame.width/2.0, y: 5.2 * view.frame.height / 7.0)
        }
        
        
        
        easyButton.position = CGPoint(x: view.frame.width * 0.8, y: view.frame.height * 0.6)
        easyButton.fillColor = .white
        easyButton.isUserInteractionEnabled = true
        easyButton.delegate = self
        easyButton.setText(text: "Easy")
        easyButton.setTextColor(color: .black)
        easyButton.setTextSize(newSize: 25)
        addChild(easyButton)
        
        
        mediumButton.position = CGPoint(x: view.frame.width * 0.8, y: view.frame.height * 0.4)
        mediumButton.fillColor = .white
        mediumButton.isUserInteractionEnabled = true
        mediumButton.delegate = self
        mediumButton.setText(text: "Medium")
        mediumButton.setTextColor(color: .black)
        mediumButton.setTextSize(newSize: 25)
        addChild(mediumButton)
        
        
        hardButton.position = CGPoint(x: view.frame.width * 0.8, y: view.frame.height * 0.2)
        hardButton.fillColor = .white
        hardButton.isUserInteractionEnabled = true
        hardButton.delegate = self
        hardButton.setText(text: "Hard")
        hardButton.setTextColor(color: .black)
        hardButton.setTextSize(newSize: 25)
        addChild(hardButton)
        
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
        /*if(sender == optionsButton){
            
        }*/
        
        if(sender == aboutButton){
            menuDelegate?.goToAbout(sender: self)
        }
        
        if(sender == easyButton){
            selectedDif = Level.easy
            easyButton.fillColor = UIColor(named: "SecondOrange")!
            mediumButton.fillColor = .white
            hardButton.fillColor = .white
        }
        if(sender == mediumButton){
            selectedDif = Level.medium
            easyButton.fillColor = .white
            mediumButton.fillColor = UIColor(named: "SecondOrange")!
            hardButton.fillColor = .white
        }
        if(sender == hardButton){
            selectedDif = Level.hard
            easyButton.fillColor = .white
            mediumButton.fillColor = .white
            hardButton.fillColor = UIColor(named: "SecondOrange")!
        }
    }
}
