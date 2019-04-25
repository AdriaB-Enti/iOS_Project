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

class GameViewController: UIViewController, MenuSceneDelegate, AboutSceneDelegate, GameSceneDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let userId = "FF4F2CA9-0D9F-4E03-A300-6494A46CE32F" //UUID().uuidString
        
        Preferences().getUserID()
        
        //FirestoreRepository().updateUserScore(score: 6, username: "eladri", userId: userId)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size: view.frame.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.menuDelegate = self
            
            // Present the scene
            view.presentScene(scene)
            
            //view.showsFPS = true
            //view.showsNodeCount = true
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
    
    func goToMenu(sender: AboutScene) {
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
        }
    }
    
    func goToGame(sender: MenuScene, level:Level) {
        if let view = self.view as? SKView{
            let scene = GameScene(size: view.frame.size)
            scene.startDif = level
            scene.scaleMode = .aspectFill
            scene.gameDelegate = self
            view.presentScene(scene, transition: .fade(withDuration: 0.3))
        }
    }
    
    func goToMenu(sender: GameScene) {
        if let view = self.view as? SKView{
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .reveal(with: .right, duration: 0.3))
        }
    }
    
}
