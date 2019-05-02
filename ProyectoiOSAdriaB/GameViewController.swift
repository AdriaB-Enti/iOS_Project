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
import FirebaseAnalytics
import GoogleMobileAds

class GameViewController: UIViewController, MenuSceneDelegate, AboutSceneDelegate, GameSceneDelegate, GADBannerViewDelegate {

    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addBanner()
        
        
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
            deleteBanner()
            let scene = GameScene(size: view.frame.size)
            scene.startDif = level
            scene.scaleMode = .aspectFill
            scene.gameDelegate = self
            view.presentScene(scene, transition: .fade(withDuration: 0.3))
        }
    }
    
    func goToMenu(sender: GameScene) {
        if let view = self.view as? SKView{
            addBanner()
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene, transition: .reveal(with: .right, duration: 0.3))
        }
    }
   
    //TODO: cridar des del gameScene amb el nivell que toqui
    //per quan tingui forma de passar al següent nivell, podem registrar un event
    func goToNextLevel(sender:GameScene, level: Level){
        //Analytics.logEvent("nextLevel", parameters: ["levelName": level.rawValue])
        if let view = self.view as? SKView{
            let scene = GameScene(size: view.frame.size)
            scene.startDif = level
            scene.scaleMode = .aspectFill
            scene.gameDelegate = self
            view.presentScene(scene, transition: .fade(withDuration: 0.3))
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .left,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .left,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func deleteBanner(){
        bannerView.removeFromSuperview()
    }
    
    func addBanner(){
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        //Delegate
        bannerView.delegate = self
    }
}
