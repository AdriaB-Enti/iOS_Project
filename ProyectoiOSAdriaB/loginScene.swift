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
    private var registerButton = Button(rect: CGRect(x: 0, y: 0, width: 220, height: 70), cornerRadius: 15)
    
    
    weak var loginDelegate: LoginDelegate?
    
    //weak var loginDelegate:LoginSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(named: "myBlue")!
        
        labelUsername = SKLabelNode(fontNamed: "HeroesLegend")
        if let labelUsername = self.labelUsername{
            labelUsername.text = NSLocalizedString("Username", comment: "username field")
            labelUsername.fontSize = 18
            labelUsername.fontColor = UIColor(named: "myOrange")!
            labelUsername.position = CGPoint(x: (view.frame.width*0.3), y: (0.65*view.frame.height))
            addChild(labelUsername)
        }
        
        /*labelPassword = SKLabelNode(fontNamed: "HeroesLegend")
        if let labelPassword = self.labelPassword{
            labelPassword.text = "Password"
            labelPassword.fontSize = 18
            labelPassword.color = UIColor(named: "myOrange")!
            labelPassword.position = CGPoint(x: (view.frame.width*0.3), y: (0.35*view.frame.height))
            addChild(labelPassword)
        }*/
        
        userTxtField = UITextField(frame: CGRect(x: (view.frame.width*0.5), y: (view.frame.height*0.28), width: view.frame.width * 0.25, height: view.frame.height * 0.1))
        if let userTextField = self.userTxtField{
            userTextField.placeholder = NSLocalizedString("Username", comment: "username input")
            userTextField.backgroundColor = .white
            view.addSubview(userTextField)
        }
        
        /*passTxtField = UITextField(frame: CGRect(x: (view.frame.width*0.5), y: (view.frame.height*0.6), width: view.frame.width * 0.25, height: view.frame.height * 0.1))
        if let passTxtField = self.passTxtField{
            //passTxtField.attributedText = "test"
            passTxtField.placeholder = "Password"
            passTxtField.isSecureTextEntry = true
            passTxtField.backgroundColor = .gray
            view.addSubview(passTxtField)
        }*/
        
        registerButton.fillColor = UIColor(named: "myOrange")!
        registerButton.setTextColor(color: .black)
        registerButton.position = CGPoint(x: (view.frame.width/2.0) - registerButton.frame.width/2.0, y: (view.frame.height / 3.0) - registerButton.frame.height/2.0)
        registerButton.setText(text: NSLocalizedString("Register", comment: "register button"))
        registerButton.setTextSize(newSize: 22)
        registerButton.delegate = self
        registerButton.isUserInteractionEnabled = true
        addChild(registerButton)
        
    }
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let txtField = self.userTxtField{
            if(!txtField.frame.contains(pos)){
                dismissKeyboard()
            }
            
        }
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
        //var fr = FirestoreRepository()
        //fr.loginPlayer(user: "hello",password: "pass")
        
        
        //guardar a preferences
        if let txtField = self.userTxtField{
            if(txtField.text?.isEmpty ?? false){
                print("you cant have an empty username")
                //
            } else{
                Preferences().saveUserName(name: txtField.text ?? "newUsername")

                dismissKeyboard()
                txtField.removeFromSuperview()
                loginDelegate?.goToMenu(sender: self)
            }
        }
    }
    
    func dismissKeyboard(){
        self.view?.endEditing(true)
    }
    
}

