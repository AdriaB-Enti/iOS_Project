//
//  MenuScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 7/3/19.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol MenuSceneDelegate: class {
    func goToAbout(sender: MenuScene)
    func goToGame(sender: MenuScene, level:Level)
    func goToScores(sender: MenuScene)
}

class MenuScene: SKScene, ButtonDelegate {
    
    private var label : SKLabelNode?
    
    weak var menuDelegate: MenuSceneDelegate?
    
    var logo :SKSpriteNode?
    
    //MENU BUTTONS
    private var startButton = Button(rect: CGRect(x: 0, y: 0, width: 300, height: 100), cornerRadius: 15)
    
    private var scoresButton = Button(rect: CGRect(x: 0, y: 0, width: 255, height: 76), cornerRadius: 15)
    let easyButton = Button(rect: CGRect(x: 0, y: 0, width: 155, height: 60), cornerRadius: 15)
    let mediumButton = Button(rect: CGRect(x: 0, y: 0, width: 155, height: 60), cornerRadius: 15)
    let hardButton = Button(rect: CGRect(x: 0, y: 0, width: 155, height: 60), cornerRadius: 15)
    var audioButton = ImageButton(rect: CGRect(x: 0, y: 0, width: 80, height: 80), cornerRadius: 25)
    
    
    
    var selectedDif = Level.easy
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(named: "myBlue")!
        //Button init
        startButton.fillColor = UIColor(named: "myOrange")!
        startButton.position = CGPoint(x: (view.frame.width/2.0) - startButton.frame.width/2.0, y: (1.35*view.frame.height / 3.0) - startButton.frame.height/2.0)
        startButton.isUserInteractionEnabled = true  //activate events
        startButton.delegate = self
        startButton.setText(text: NSLocalizedString("PlayButton", comment: "play button"))
        startButton.setTextColor(color: .black)
        addChild(startButton)
        
        //audioButton.setImage(image: "sound_icon")
        setAudioButtonImage(musicEnabled: Preferences().getMusicEnabled())
        audioButton.isUserInteractionEnabled = true
        audioButton.delegate = self
        audioButton.position = CGPoint(x: (audioButton.buttonImage?.size.width ?? 200)/2.0, y: (1.35*view.frame.height / 3.0) - startButton.frame.height/2.5)
        addChild(audioButton)
        
        
        scoresButton.fillColor = UIColor(named: "myOrange")!
        scoresButton.position = CGPoint(x: (view.frame.width/2.0) - scoresButton.frame.width/2.0, y: (view.frame.height / 5.5) - scoresButton.frame.height/2.0)
        scoresButton.isUserInteractionEnabled = true
        scoresButton.delegate = self
        scoresButton.setText(text: NSLocalizedString("HighScores", comment: "scores button"))
        scoresButton.setTextSize(newSize: 18)
        scoresButton.setTextColor(color: .black)
        addChild(scoresButton)
        
        
        self.label = SKLabelNode(text:"Magic Memorizer")
        if let label = self.label {
            //label.alpha = 0.0
            addChild(label)
            label.fontName = "HeroesLegend"
            label.fontColor = UIColor(named: "SecondOrange")!
            
            label.fontSize = 35
            label.position = CGPoint(x: view.frame.width/2.0, y: 5.2 * view.frame.height / 7.4)
        }
        
        
        easyButton.position = CGPoint(x: view.frame.width * 0.75, y: (view.frame.height * 0.6) - label!.frame.height/2.0)
        easyButton.fillColor = UIColor(named: "SecondOrange")!
        easyButton.isUserInteractionEnabled = true
        easyButton.delegate = self
        easyButton.setText(text: NSLocalizedString("EasyDifficulty", comment: "easy button"))
        easyButton.setTextColor(color: .black)
        easyButton.setTextSize(newSize: 19)
        addChild(easyButton)
        
        
        mediumButton.position = CGPoint(x: view.frame.width * 0.75, y: view.frame.height * 0.4 - label!.frame.height/2.0)
        mediumButton.fillColor = .white
        mediumButton.isUserInteractionEnabled = true
        mediumButton.delegate = self
        mediumButton.setText(text: NSLocalizedString("MediumDifficulty", comment: "medium button"))
        mediumButton.setTextColor(color: .black)
        mediumButton.setTextSize(newSize: 19)
        addChild(mediumButton)
        
        
        hardButton.position = CGPoint(x: view.frame.width * 0.75, y: view.frame.height * 0.2 - label!.frame.height/2.0)
        hardButton.fillColor = .white
        hardButton.isUserInteractionEnabled = true
        hardButton.delegate = self
        hardButton.setText(text: NSLocalizedString("HardDifficulty", comment: "hard button"))
        hardButton.setTextColor(color: .black)
        hardButton.setTextSize(newSize: 19)
        addChild(hardButton)
        
        setDifButton(currentDif: Preferences().getDefaultLevel())
    }
    
    func setAudioButtonImage(musicEnabled:Bool){
        if(musicEnabled){
            audioButton.setImage(image: "sound_icon")
        } else{
            audioButton.setImage(image: "sound_disabled_icon")
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
        
        
    }
    
    func setDifButton(currentDif:Level){
        
        switch currentDif {
            
        case Level.easy:
            easyButton.fillColor = UIColor(named: "SecondOrange")!
            mediumButton.fillColor = .white
            hardButton.fillColor = .white
            
        case Level.medium:
            easyButton.fillColor = .white
            mediumButton.fillColor = UIColor(named: "SecondOrange")!
            hardButton.fillColor = .white
            
        case Level.hard:
            easyButton.fillColor = .white
            mediumButton.fillColor = .white
            hardButton.fillColor = UIColor(named: "SecondOrange")!
        }
        
        selectedDif = currentDif
        Preferences().setDefaultLevel(level:currentDif)
    }
    
    func onTap(sender: Button) {
        if(sender == audioButton){
            Preferences().toggleMusic()
            setAudioButtonImage(musicEnabled: Preferences().getMusicEnabled())
        }
        if(sender == startButton){
            print("calling delegate")
            menuDelegate?.goToGame(sender: self, level: selectedDif)
        }
        /*if(sender == optionsButton){
            
        }*/
        
        if(sender == scoresButton){
            menuDelegate?.goToScores(sender: self)
        }
        
        if(sender == easyButton){
            setDifButton(currentDif: Level.easy)
        }
        if(sender == mediumButton){
            setDifButton(currentDif: Level.medium)
        }
        if(sender == hardButton){
            setDifButton(currentDif: Level.hard)
        }
    }
}
