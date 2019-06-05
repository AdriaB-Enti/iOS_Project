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
    
    //private var labelUsername : SKLabelNode?
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: 220, height: 70), cornerRadius: 15)
    
    
    weak var loginDelegate: LoginDelegate?
    
    //weak var loginDelegate:LoginSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(named: "myBlue")!
        
        backButton.fillColor = UIColor(named: "myOrange")!
        backButton.setTextColor(color: .black)
        backButton.position = CGPoint(x: (view.frame.width/2.0) - backButton.frame.width/2.0, y: (view.frame.height / 3.0) - backButton.frame.height/2.0)
        backButton.setText(text: NSLocalizedString("BackButton", comment: "back button"))
        backButton.setTextSize(newSize: 22)
        backButton.delegate = self
        backButton.isUserInteractionEnabled = true
        addChild(backButton)
        
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
    }
    
    func onTap(sender: Button) {
        
    }
    
    
}

