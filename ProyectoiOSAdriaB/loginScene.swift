//
//  loginScene.swift
//  ProyectoiOSAdriaB
//
//  Created by Entipro on 2019/5/3.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//


import SpriteKit
import GameplayKit
import CoreLocation

protocol LoginDelegate: class {
    func goToMenu(sender: LoginScene)
}

class LoginScene: SKScene, ButtonDelegate {
    
    private var labelUsername : SKLabelNode?
    private var labelPassword : SKLabelNode?
    private var userTxtField : UITextField?
    private var passTxtField : UITextField?
    private var loginButton = Button(rect: CGRect(x: 0, y: 0, width: 150, height: 70), cornerRadius: 15)
    private var registerButton = Button(rect: CGRect(x: 0, y: 0, width: 150, height: 70), cornerRadius: 15)
    
    weak var loginDelegate: LoginDelegate?
    //TODO: ADD username and password text input, button to login
    //Then add implementation of that
    
    //weak var loginDelegate:LoginSceneDelegate?
    //var atestCard :SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        labelUsername = SKLabelNode(fontNamed: "HeroesLegend")
        if let labelUsername = self.labelUsername{
            labelUsername.text = "Username"
            labelUsername.fontSize = 18
            labelUsername.color = UIColor(named: "myOrange")!
            labelUsername.position = CGPoint(x: (view.frame.width*0.3), y: (0.75*view.frame.height))
            addChild(labelUsername)
        }
        
        labelPassword = SKLabelNode(fontNamed: "HeroesLegend")
        if let labelPassword = self.labelPassword{
            labelPassword.text = "Password"
            labelPassword.fontSize = 18
            labelPassword.color = UIColor(named: "myOrange")!
            labelPassword.position = CGPoint(x: (view.frame.width*0.3), y: (0.35*view.frame.height))
            addChild(labelPassword)
        }
        
        userTxtField = UITextField(frame: CGRect(x: (view.frame.width*0.5), y: (view.frame.height*0.2), width: view.frame.width * 0.25, height: view.frame.height * 0.1))
        if let userTextField = self.userTxtField{
            userTextField.placeholder = "Name"
            userTextField.backgroundColor = .gray
            view.addSubview(userTextField)
        }
        
        passTxtField = UITextField(frame: CGRect(x: (view.frame.width*0.5), y: (view.frame.height*0.6), width: view.frame.width * 0.25, height: view.frame.height * 0.1))
        if let passTxtField = self.passTxtField{
            //passTxtField.attributedText = "test"
            passTxtField.placeholder = "Password"
            passTxtField.isSecureTextEntry = true
            passTxtField.backgroundColor = .gray
            view.addSubview(passTxtField)
        }
        
        loginButton.fillColor = UIColor(named: "myOrange")!
        loginButton.position = CGPoint(x: (view.frame.width/2.0) - loginButton.frame.width/2.0, y: (view.frame.height / 5.0) - loginButton.frame.height/2.0)
        loginButton.setText(text: "Login")
        loginButton.delegate = self
        loginButton.isUserInteractionEnabled = true
        addChild(loginButton)
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
    
    func onTap(sender: Button) {
        var fr = FirestoreRepository()
        fr.loginPlayer(user: "hello",password: "pass")
        
    }
    
    
    
}

