//
//  GameScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 1/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, CardDelegate, GameLogicDelegate {
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var gameLogic = GameLogic()
    private var cardSprites = [CardSprite]()
    private var cardtest = CardSprite()
    
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
        gameLogic.delegate = self
        
        var cardCount = 0
        let TOTAL_ROWS = 2
        var totalCols = gameLogic.cards.count / TOTAL_ROWS
        
        for row in 0...TOTAL_ROWS-1{
            for col in 0...totalCols-1{
                let card = gameLogic.cards[col + row * totalCols]
                print("textureName " + card.textureFront)
                let aCard = CardSprite(imageNamed: card.textureBack)
                aCard.cardID = card.id
                aCard.isUserInteractionEnabled = true
                aCard.delegate = self
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
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        print("touch scne")
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
        
        //testing per provar d'anar movent el logo
        /*if let logo = self.logo{
            //logo.position.x += 0.01
            
        }*/

    }
    
    func onTap(sender: CardSprite) {
        
        
        
        
        gameLogic.selectCard(cardInd: sender.cardID)
        print("card \(sender.cardID)pressed")
    }
    
    func cardUntapped(idCard: Int) {
        print("untapping\(idCard)")
        for cardSp in cardSprites{
            if(cardSp.cardID  == idCard){
                //animacio de carta girada
                
                var originalXscale = cardSp.xScale
                
                let pulse = SKAction.sequence([ SKAction.scaleX(to: 0.0, y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse)
                //sender.texture = SKTexture(imageNamed:  "aCard")
                //wait 0.7
                let pulse2 = SKAction.sequence([SKAction.wait(forDuration: 0.3), SKAction.setTexture(SKTexture(imageNamed:  "aCard")),
                                                SKAction.scaleX(to: originalXscale, y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                
                cardSp.run(pulse2)
            }
        }
    }
    
    func gameFinished() {
        print("gameFinished")
    }
    
    func cardTapped(idCard: Int, newTexture:String) {
        for cardSp in cardSprites{
            if(cardSp.cardID  == idCard){
                //animacio de carta girada
                
                var originalXscale = cardSp.xScale
                
                let pulse = SKAction.sequence([ SKAction.scaleX(to: 0.0, y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse)
                //sender.texture = SKTexture(imageNamed:  "aCard")
                //wait 0.7
                let pulse2 = SKAction.sequence([SKAction.wait(forDuration: 0.3), SKAction.setTexture(SKTexture(imageNamed:  newTexture)),
                                                SKAction.scaleX(to: originalXscale, y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                
                cardSp.run(pulse2)
            }
        }
        
        
        
        print("cardTapped")
    }
}
