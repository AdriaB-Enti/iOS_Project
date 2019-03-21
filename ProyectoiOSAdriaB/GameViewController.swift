//
//  GameViewController.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 1/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, MenuSceneDelegate, AboutSceneDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size: view.frame.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.menuDelegate = self
            
            // Present the scene
            view.presentScene(scene)
            
            
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func goBack(sender: AboutScene) {
        if let view = self.view as? SKView{
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .reveal(with: .right, duration: 0.3))
        }
    }
    
    func goToAbout(sender: MenuScene) {
        print("goto game controller method")
        if let view = self.view as? SKView{
            print("if let ok")
            let scene = AboutScene(size: view.frame.size)
            scene.aboutDelegate = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .reveal(with: .left, duration: 0.4))
            //view.presentScene(scene)
        }
    }
    
    func goToGame(sender: MenuScene) {
        if let view = self.view as? SKView{
            let scene = GameScene(size: view.frame.size)
            //delegate
            scene.scaleMode = .aspectFill
            //view.presentScene(scene, transition: .reveal(with: .left, duration: 0.3))
            view.presentScene(scene)
        }
    }
}
