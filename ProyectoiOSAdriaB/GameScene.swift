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
    private var gameLogic = GameLogic()
    private var cardSprites = [CardSprite]()
    private var cardTests = [CardSprite]()
    
    //var atestCard :SKSpriteNode?
    
    override func didMove(to view: SKView) {
        print("start")
        
        /*
        self.label = SKLabelNode(text:"test scene")
        if let label = self.label {
            //label.alpha = 0.0
            addChild(label)
            label.color = SKColor.white
            label.position = view.center
            //label.run(SKAction.fadeIn(withDuration: 2.0))
        }*/
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        
        
        /*self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }*/
        
        
        gameLogic.start()
        
        var cardCount = 0
        let TOTAL_ROWS = 2
        var totalCols = gameLogic.cards.count / TOTAL_ROWS
        
        for row in 0...TOTAL_ROWS-1{
            for col in 0...totalCols-1{
                let card = gameLogic.cards[cardCount]
                print("textureName " + card.textureFront)
                let aCard = CardSprite(imageNamed: card.textureFront)
                aCard.cardID = cardCount
                //position cards based on number of cards
                let cardWidth = 200.0
                let separation = (Double(view.frame.width) / Double(gameLogic.cards.count)) - (cardWidth / 2.0)
                
                //TODO posicionar bé
                //aCard.position = CGPoint(x: Double(col * 20), y: Double(row * 200))
                aCard.position = CGPoint(x: separation + cardWidth/2.0 + Double(col) * (separation+cardWidth), y: Double(view.frame.height) / 4.0 + Double(row) * Double(view.frame.height) / 3.0)
                aCard.scale(to: CGSize(width: 200, height: 300))
                cardSprites.append(aCard)
                
                addChild(cardSprites.last!)
                
                
                cardCount += 1
            }
        }
        
        
        
        var atestCard = CardSprite(imageNamed: "aCard")
        atestCard.position = CGPoint(x: 120, y: 120)
        cardTests.append(atestCard)
        //addChild(cardTests.last!)
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
        //TODO fer un for i mirar quina de les cartes es
        //cridar el gameLogic i el metode que toca (selectedCard)
        
        /*if (sender == gameButton) {
            print("scene game button")
        }*/
    }
}
