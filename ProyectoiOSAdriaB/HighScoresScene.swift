//
//  HighScoresScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Entipro on 2019/5/30.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

protocol HighScoresDelegate: class {
    func goToMenu(sender: HighScoresScene)
}

class HighScoresScene: SKScene, ButtonDelegate {
    
    private var labelScores : SKLabelNode?
    private var waitingLabel : SKLabelNode?
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: 105, height: 60), cornerRadius: 15)
    private var dataRecieved = false
    var allScores:Array<String> = []
    
    weak var scoresDelegate: HighScoresDelegate?
    
    //weak var loginDelegate:LoginSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        self.labelScores = SKLabelNode(text:NSLocalizedString("HighScores", comment: "High scores title"))
        
        if let label = self.labelScores {
            addChild(label)
            label.fontName = "HeroesLegend"
            label.fontColor = UIColor(named: "SecondOrange")!
            label.fontSize = 35
            label.position = CGPoint(x: view.frame.width/2.0, y: 6.0 * view.frame.height / 7.0)
        }
        
        self.waitingLabel = SKLabelNode(text:NSLocalizedString("Loading", comment: "Loading label"))
        if let waitLabel = self.waitingLabel {
            addChild(waitLabel)
            waitLabel.fontName = "HeroesLegend"
            waitLabel.fontColor = UIColor(named: "SecondOrange")!
            waitLabel.fontSize = 25
            waitLabel.position = CGPoint(x: view.frame.width/2.0, y: view.frame.height / 2.0)
        }
        
        
        self.backgroundColor = UIColor(named: "myBlue")!
        
        backButton.fillColor = UIColor(named: "myOrange")!
        backButton.setTextColor(color: .black)
        backButton.position = CGPoint(x: 0, y: view.frame.height - backButton.frame.height)
        backButton.setText(text: NSLocalizedString("BackButton", comment: "back button"))
        backButton.setTextSize(newSize: 18)
        backButton.delegate = self
        backButton.isUserInteractionEnabled = true
        addChild(backButton)
       
        FirestoreRepository().getScores(completion: { scores in
            self.allScores = scores
            self.updateScores(v:view,theScores:scores)
        })
        /*for score in allScores{
            print(score)
        }*/
        
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
    
    func updateScores(v:SKView, theScores:[String]){
        
        self.waitingLabel?.removeFromParent()
        
        var counter = 1
        let spacing = v.frame.height/8
        for score in theScores{
            let aScore = SKLabelNode(text:score)
            aScore.fontName = "HeroesLegend"
            aScore.fontColor = UIColor(named: "SecondOrange")!
            aScore.fontSize = 15
            
            
            
            aScore.position = CGPoint(x: v.frame.width/2.0, y: labelScores!.position.y - spacing * CGFloat(counter))
            self.addChild(aScore)
            counter += 1
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
    
    func onTap(sender: Button) {
        if(sender == backButton){
            scoresDelegate?.goToMenu(sender: self)
        }
    }
    
    
}

