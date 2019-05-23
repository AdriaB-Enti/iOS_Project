//
//  aboutScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 15/03/2019.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol AboutSceneDelegate: class {
    func goToMenu(sender: AboutScene)
}

class AboutScene: SKScene, ButtonDelegate {
    
    private var label : SKLabelNode?
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: 190, height: 70), cornerRadius: 15)
    
    weak var aboutDelegate : AboutSceneDelegate?
    
    var logo :SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        self.label = SKLabelNode(fontNamed: "HeroesLegend")
        if let label = self.label{
            label.text = NSLocalizedString("AboutButton", comment: "about")
            label.color = SKColor.yellow
            label.position = CGPoint(x: (view.frame.width/2.0), y: (4*view.frame.height / 5.0))
            addChild(label)
        }
        
        backButton.fillColor = UIColor(named: "myGray")!
        backButton.position = CGPoint(x: (view.frame.width/2.0) - backButton.frame.width/2.0, y: (view.frame.height / 5.0) - backButton.frame.height/2.0)
        backButton.isUserInteractionEnabled = true  //activate events
        backButton.delegate = self
        backButton.setText(text: NSLocalizedString("BackButton", comment: "back"))
        backButton.setTextColor(color: .white)
        addChild(backButton)
        
        let madeby = SKLabelNode()
        madeby.text = NSLocalizedString("CreatedBy", comment: "createdby")
        madeby.color = SKColor.yellow
        madeby.position = CGPoint(x: (view.frame.width/2.0), y: (view.frame.height / 2.0))
        addChild(madeby)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        print("touch scne")
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            
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
        
        
    }
    
    func onTap(sender: Button) {
        if(sender == backButton){
            aboutDelegate?.goToMenu(sender: self)
        }
        
    }
}
