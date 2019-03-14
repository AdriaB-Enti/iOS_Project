//
//  MenuScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 7/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene, ButtonDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var logo :SKSpriteNode?
    
    //MENU BUTTONS
    private var startButton = Button(rect: CGRect(x: 0, y: 0, width: 300, height: 100), cornerRadius: 10)
    
    private var optionsButton = Button(rect: CGRect(x: 0, y: 0, width: 70, height: 70), cornerRadius: 30)
    //posar un about button? potser que sigui més petit, circular amb un interrogant
    //i un help button
    //afegir més animacions pel mig, que no quedi tant estatic

    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(named: "myBlue")!
        
        
        //Button init
        startButton.fillColor = UIColor(named: "myOrange")!
        startButton.position = CGPoint(x: (view.frame.width/2.0) - startButton.frame.width/2.0, y: (view.frame.height / 3.0) - startButton.frame.height/2.0)
        startButton.isUserInteractionEnabled = true  //així activem els eventos
        startButton.delegate = self
        startButton.setText(text: "Play")
        startButton.setTextColor(color: .black)
        addChild(startButton)
        
        optionsButton.fillColor = UIColor(named: "myGray")!
        optionsButton.position = CGPoint(x: (8.75*view.frame.width/10.0) - optionsButton.frame.width/2.0, y: (9.5*view.frame.height / 10.0) - optionsButton.frame.height/2.0)
        optionsButton.isUserInteractionEnabled = true  //així activem els eventos
        optionsButton.delegate = self
        optionsButton.setText(text: "Op")
        startButton.setTextColor(color: .black)
        addChild(optionsButton)
        
        
        if var logo = self.logo{
            logo =  SKSpriteNode(imageNamed: "pica")
            logo.position = CGPoint(x: view.frame.width/2,y: view.frame.height/2)
            addChild(logo)
        }
        
        /*let logotest = SKSpriteNode(imageNamed: "pica")
        logotest.position = CGPoint(x: view.frame.width/2,y: view.frame.height/2)
        addChild(logotest)*/
        
        // Get label node from scene and store it for use later
        
        self.label = SKLabelNode(text:"Main Menu")
                
        //self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            //label.alpha = 0.0
            addChild(label)
            label.color = SKColor.white
            label.position = view.center
            
            //label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            let pulse = SKAction.sequence([ SKAction.scale(by: 0.5, duration: 0.3),  SKAction.scale(by: 2.0, duration: 0.3)])
            label.run(pulse)
            //label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
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
            if let view = self.view as! SKView? {
                let scene = MenuScene(size: view.frame.size)
                
                //scene.menudelegate = self
                //scene.scalemode = .aspectFill
            }

        }
        if(sender == optionsButton){
            
        }
    }
}
