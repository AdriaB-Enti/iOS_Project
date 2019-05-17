//
//  GameScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 1/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

protocol GameSceneDelegate: class {
    func goToMenu(sender: GameScene)
    func goToNextLevel(sender:GameScene, level:Level)
}


class GameScene: SKScene, CardDelegate, GameLogicDelegate, ButtonDelegate {
    private var labelTime : SKLabelNode?
    private var labelPoints : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var gameLogic = GameLogic()
    private var cardSprites = [CardSprite]()
    private var cardtest = CardSprite()
    private var mainMenuB = Button(rect: CGRect(x: 0, y: 0, width: 60, height: 40), cornerRadius: 15)
    private var musicPlayer: AVAudioPlayer?
    private var victorySound: AVAudioPlayer?
    var nextLevelButton = Button(rect: CGRect(x: 0, y: 0, width: 140, height: 60), cornerRadius: 5)
    
    public var startDif = Level.easy
    
    weak var gameDelegate:GameSceneDelegate?
    
    var cardWidth = 96.0
    var cardHeight = 117.0
    var originalXscale = CGFloat(1)
    var remainingTime = 60.0 {
        didSet{
            labelTime?.text = formatTimeSeconds(seconds: remainingTime)
            
        }
    }
    //var atestCard :SKSpriteNode?
    
    override func didMove(to view: SKView) {
        print("width is \(view.frame.width)")
        print("height is \(view.frame.height)")
        
        //MUSIC
        let path = Bundle.main.path(forResource: "Staying_Positive", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.play()
        } catch {
            print("Error: couldn't load the music")
        }
 
 
        nextLevelButton.setText(text: NSLocalizedString("NextLevel", comment: "NextLevel"))
        nextLevelButton.delegate = self
        
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
        mainMenuB.fillColor = UIColor(cgColor: SKColor.gray.cgColor)
        mainMenuB.position = CGPoint(x: 18.0, y: Double(view.frame.height)-45.0) //NOPE
        mainMenuB.setText(text: NSLocalizedString("BackButton", comment: "back button"))
        mainMenuB.setTextSize(newSize: 11)
        mainMenuB.isUserInteractionEnabled = true
        mainMenuB.delegate = self
        addChild(mainMenuB)
        
        
        labelTime = SKLabelNode(text: "0:0")
        labelTime?.fontSize = 19
        labelTime?.fontName = "HeroesLegend"
        labelTime?.text = formatTimeSeconds(seconds: remainingTime)
        labelTime?.position = CGPoint(x: Double(view.frame.width)*0.93, y: Double(view.frame.height)*0.93)
        if let time = labelTime{
            addChild(time)
        }
        //Timer
        let updateTimerBlock = SKAction.run({
            [unowned self] in
            
            if self.remainingTime > 0{
                self.remainingTime -= 1
            } else{
                self.removeAction(forKey: "countdown")
                self.gameLogic.gameFinished = true
                
                let labelLose = SKLabelNode(text: NSLocalizedString("Lose", comment: "lose message"))
                labelLose.position = CGPoint(x: self.view!.frame.width/2, y: self.view!.frame.height/2)
                labelLose.fontColor = .white
                labelLose.fontSize = 35
                labelLose.fontName = "HeroesLegend"
                self.addChild(labelLose)
            }
        })
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 1.0),updateTimerBlock])
        run(SKAction.repeatForever(sequence), withKey: "countdown")
        
        labelPoints = SKLabelNode(text: NSLocalizedString("Score", comment: "score")+": 0")
        labelPoints?.fontName = "HeroesLegend"
        labelPoints?.fontSize = 19
        labelPoints?.position = CGPoint(x: Double(view.frame.width)*0.70, y: Double(view.frame.height)*0.93)
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
        
        
        gameLogic.start(startdifficulty: startDif)
        remainingTime = Double(gameLogic.getLevelTime(level: startDif))
        gameLogic.delegate = self
        
        let TOTAL_ROWS = 3
        
        let totalCols = Int( ceil(Double(gameLogic.cards.count) / Double(TOTAL_ROWS)) )
        
        let x_offsetLeft = 10.0
        let y_offset = 40.0
        
        cardHeight = (Double(view.frame.height)-y_offset)/3.0
        cardWidth = (117/cardHeight) * cardWidth
        
        
        let x_separation = (Double(Double(view.frame.width) - x_offsetLeft) / Double(1 + (totalCols)))
        let y_separation = ((Double(view.frame.height)-y_offset) / Double((TOTAL_ROWS)))
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
                aCard.position = CGPoint(x: x_offsetLeft + x_separation * Double(col+1), y: Double(view.frame.height)-(Double(row) * y_separation) - y_offset - cardHeight/2.0)
                aCard.scale(to: CGSize(width: cardWidth, height: cardHeight))
                originalXscale = aCard.xScale
                cardSprites.append(aCard)
                
                addChild(cardSprites.last!)
            }
        }
        
    }
    
    func formatTimeSeconds(seconds:Double) -> String{
        
        var minutes = Int(seconds) / 60
        var remSec = Int(seconds - Double(minutes) * 60.0)
        
        return "\(minutes):\(remSec)"
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
        //remainingTime -= currentTime
        //labelTime?.text = "\(remainingTime)"
        //labelTime?.text = formatTimeSeconds(seconds: remainingTime)
        //labelTime?.text = "\(currentTime)"
    }
    
    func onCardTap(sender: CardSprite) {
        if(!gameLogic.gameFinished){
            gameLogic.selectCard(cardInd: sender.cardID)
            print("card \(sender.cardID)pressed")
        }
    }
    
    func onTap(sender: Button) {
        if(sender == mainMenuB){
            musicPlayer?.stop()
            removeAction(forKey: "countdown")
            gameDelegate?.goToMenu(sender: self)
        }
        if(sender == nextLevelButton){
            musicPlayer?.stop()
            //fer el mateix que el goToGame
            if(startDif == Level.easy){
                gameDelegate?.goToNextLevel(sender: self, level: Level.medium)
            }
            else if(startDif == Level.medium){
                gameDelegate?.goToNextLevel(sender: self, level: Level.hard)
            }
            
            //TODO: now is hardcoded, check what the next level is (i potser posar un metode per obtenir el seguent nivell)
        }
    }
    
    //Go back to leave the card showing its back
    func cardUntapped(idCard: Int) {
        print("untapping\(idCard)")
        for cardSp in cardSprites{
            if(cardSp.cardID  == idCard){
                //animacio de carta girada
                //var originalXscale = cardSp.xScale
                let pulse = SKAction.sequence([SKAction.wait(forDuration: 0.9), SKAction.scaleX(to: 0.0, y: cardSp.yScale, duration: 0.2)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse)
                
                let pulse2 = SKAction.sequence([SKAction.wait(forDuration: 1.1), SKAction.setTexture(SKTexture(imageNamed:  "CardBack")),
                                                SKAction.scaleX(to: CGFloat(originalXscale), y: cardSp.yScale, duration: 0.2)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse2)
            }
        }
    }
    
    func gameFinished(win: Bool) {
        musicPlayer?.stop()
        print("gameFinished------------------------")
        removeAction(forKey: "countdown")
        if(win){
            let path = Bundle.main.path(forResource: "victory", ofType:"aiff")!
            do {
                victorySound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                victorySound?.play()
            } catch {
                print("Error: couldn't load victory sound")
            }
            
            let labelWin = SKLabelNode(text: NSLocalizedString("Win", comment: "win message"))
            labelWin.position = CGPoint(x: self.view!.frame.width/2, y: self.view!.frame.height/2)
            labelWin.fontColor = .white
            labelWin.fontSize = 35
            labelWin.fontName = "HeroesLegend"
            addChild(labelWin)

            if(startDif != Level.hard){
                nextLevelButton = Button(rect: CGRect(x: 0, y: 0, width: 190, height: 60), cornerRadius: 5)
                nextLevelButton.position = CGPoint(x: (self.view!.frame.width/2)-190/2, y: self.view!.frame.height * 0.3)
                nextLevelButton.fillColor = UIColor(named: "myOrange")!
                nextLevelButton.delegate = self
                nextLevelButton.setText(text: NSLocalizedString("NextLevel", comment: "NextLevel"))
                nextLevelButton.isUserInteractionEnabled = true
                nextLevelButton.setTextSize(newSize: 15)
                addChild(nextLevelButton)
            }
        }
    }
    
    //Spin for the first Time
    func cardTapped(idCard: Int, newTexture:String) {
        for cardSp in cardSprites{
            if(cardSp.cardID  == idCard){
                //var originalXscale = cardSp.xScale
                
                let pulse = SKAction.sequence([ SKAction.scaleX(to: 0.0, y: cardSp.yScale, duration: 0.2)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse)
                
                let pulse2 = SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.setTexture(SKTexture(imageNamed:  newTexture)),
                                                SKAction.scaleX(to: CGFloat(originalXscale), y: cardSp.yScale, duration: 0.2)]) //,  SKAction.scaleX(by: 1, y: 1, duration: 0.3)
                cardSp.run(pulse2)
            }
        }
        
        print("cardTapped")
    }
    
    func pointsAdded(totalPoints:Int) {
        //canviar el text de la labe de points amb els nous
        labelPoints?.text = NSLocalizedString("Score", comment: "score")+": \(totalPoints)"
        print("points in game scene!!")
    }
}
