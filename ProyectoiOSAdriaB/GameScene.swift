//
//  GameScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 1/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate: class {
    func goToMenu(sender: GameScene)
}

class GameScene: SKScene, CardDelegate, GameLogicDelegate, ButtonDelegate {
    private var labelTime : SKLabelNode?
    private var labelPoints : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var gameLogic = GameLogic()
    private var cardSprites = [CardSprite]()
    private var cardtest = CardSprite()
    private var mainMenuB = Button(rect: CGRect(x: 35, y: 100, width: 40, height: 40), cornerRadius: 15)
    
    weak var gameDelegate:GameSceneDelegate?
    
    var cardWidth = 96.0
    var cardHeight = 117.0
    var originalXscale = CGFloat(1)
    //var atestCard :SKSpriteNode?
    
    override func didMove(to view: SKView) {
        print("width is \(view.frame.width)")
        print("height is \(view.frame.height)")
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
        //mainMenuB.position.y = CGFloat(view.frame.height)*0.9
        mainMenuB.fillColor = UIColor(named: "myOrange")!
        mainMenuB.delegate = self
        addChild(mainMenuB)
        
        
        labelTime = SKLabelNode(text: "0:0")
        labelTime?.position = CGPoint(x: Double(view.frame.width)*0.95, y: Double(view.frame.height)*0.9)
        if let time = labelTime{
            addChild(time)
        }
        
        labelPoints = SKLabelNode(text: "Score: 0")
        labelPoints?.position = CGPoint(x: Double(view.frame.width)*0.70, y: Double(view.frame.height)*0.9)
        if let points = labelPoints{
            addChild(points)
        }
        
        /*self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }*/
        
        
        gameLogic.start(startdifficulty: Level.medium)
        gameLogic.delegate = self
        
        let TOTAL_ROWS = 3
        
        let totalCols = Int( ceil(Double(gameLogic.cards.count) / Double(TOTAL_ROWS)) )
        
        let x_offsetLeft = 10.0
        
        
        let x_separation = (Double(Double(view.frame.width) - x_offsetLeft) / Double(1 + (totalCols)))
        let y_separation = (Double(view.frame.height) / Double(1 + (TOTAL_ROWS)))
        let y_offset = -10.0
        print("totalcols\(totalCols) ")
        print("separation \(Double(1 + (totalCols)))")
        
        for row in 0...TOTAL_ROWS-1{
            for col in 0...totalCols-1{
                if((col + row * totalCols) == gameLogic.cards.count){
                    break;
                }
                
                let card = gameLogic.cards[col + row * totalCols]
                let aCard = CardSprite(imageNamed: card.textureBack)
                aCard.cardID = card.id
                aCard.isUserInteractionEnabled = true
                aCard.delegate = self
                //position cards based on number of cards
                //let separation = (Double(view.frame.width) / Double(gameLogic.cards.count)) - (cardWidth / 2.0)
                
                //TODO posicionar bé
                //aCard.position = CGPoint(x: Double(col * 20), y: Double(row * 200))
                //aCard.position = CGPoint(x: separation + cardWidth/2.0 + Double(col) * (separation+cardWidth), y: Double(view.frame.height) / 4.0 + Double(row) * Double(view.frame.height) / 3.0)
                aCard.position = CGPoint(x: x_offsetLeft + x_separation * Double(col+1), y: Double(view.frame.height)-(Double(1+row) * y_separation) + y_offset)
                aCard.scale(to: CGSize(width: cardWidth, height: cardHeight))
                originalXscale = aCard.xScale
                cardSprites.append(aCard)
                
                addChild(cardSprites.last!)
            }
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
        
        //testing per provar d'anar movent el logo
        /*if let logo = self.logo{
            //logo.position.x += 0.01
            
        }*/

    }
    func onTap(sender: Button) {
        print("ontapB")
        if(sender == mainMenuB){
            print("ontap Main Menu B")
            gameDelegate?.goToMenu(sender: self)
        }
    }
    func onTap(sender: CardSprite) {
        gameLogic.selectCard(cardInd: sender.cardID)
        print("card \(sender.cardID)pressed")
    }
    
    
    
    //Go back to leave the card showing  its back
    func cardUntapped(idCard: Int) {
        print("untapping\(idCard)")
        for cardSp in cardSprites{
            if(cardSp.cardID  == idCard){
                //animacio de carta girada
                print("untapping card")
                //var originalXscale = cardSp.xScale
                let pulse = SKAction.sequence([SKAction.wait(forDuration: 0.9), SKAction.scaleX(to: 0.0, y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse)
                
                let pulse2 = SKAction.sequence([SKAction.wait(forDuration: 1.2), SKAction.setTexture(SKTexture(imageNamed:  "CardBack")),
                                                SKAction.scaleX(to: CGFloat(originalXscale), y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse2)
                print("untap")
            }
        }
    }
    
    func gameFinished() {
        print("gameFinished")
    }
    
    //Spin for the first Time
    func cardTapped(idCard: Int, newTexture:String) {
        for cardSp in cardSprites{
            if(cardSp.cardID  == idCard){
                //var originalXscale = cardSp.xScale
                
                let pulse = SKAction.sequence([ SKAction.scaleX(to: 0.0, y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse)
                
                let pulse2 = SKAction.sequence([SKAction.wait(forDuration: 0.3), SKAction.setTexture(SKTexture(imageNamed:  newTexture)),
                                                SKAction.scaleX(to: CGFloat(originalXscale), y: cardSp.yScale, duration: 0.3)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse2)
            }
        }
        
        print("cardTapped")
    }
    
    func pointsAdded(totalPoints:Int) {
        //canviar el text de la labe de points amb els nous
        labelPoints?.text = "Score: \(totalPoints)"
        print("points in game scene!!")
        
    }
}
