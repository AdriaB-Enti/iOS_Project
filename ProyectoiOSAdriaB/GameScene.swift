//
//  GameScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 1/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, ButtonDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var gameButton = Button(rect: CGRect(x: 0, y: 0, width: 200, height: 50), cornerRadius: 10)
    private var settingsButton = Button(rect: CGRect(x: 0, y: 0, width: 100, height: 50), cornerRadius: 10)
    
    var logo :SKSpriteNode?
    
    override func didMove(to view: SKView) {
        print("start")
        gameButton.fillColor = .red
        gameButton.position = CGPoint(x: view.frame.width/3.0, y: view.frame.height / 3.0)
        gameButton.isUserInteractionEnabled = true  //així activem els eventos
        gameButton.delegate = self
        addChild(gameButton)
        
        settingsButton.fillColor = .blue
        settingsButton.position = CGPoint(x: view.frame.width/2.0, y: view.frame.height / 8.0)
        settingsButton.isUserInteractionEnabled = true  //així activem els eventos
        settingsButton.delegate = self
        addChild(settingsButton)
        
        
        if var logo = self.logo{
            logo =  SKSpriteNode(imageNamed: "pica")
            logo.position = CGPoint(x: view.center.x,y: view.center.y+100);
            addChild(logo)
        }
        
        
        // Get label node from scene and store it for use later
        
        self.label = SKLabelNode(text:"holaaaa")
        
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
        print("touch scne")
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
        
        //testing per provar d'anar movent el logo
        /*if let logo = self.logo{
            //logo.position.x += 0.01
            
        }*/

    }
    
    func onTap(sender: Button) {
        
        if (sender == gameButton) {
            print("scene game button")
        }
    }
}
