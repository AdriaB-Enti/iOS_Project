//
//  File.swift
//  ProyectoiOSAdriaB
//
//  Created by Entipro on 2019/4/25.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation
import Firebase


class FirestoreRepository {
    
    let K_COLLECTION_SCORES = "scores"
    
    func loginPlayer(user: String, password: String){
        print("login")
        //Auth.auth().signIn(withCustomToken: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
        //Auth.auth().create
        
    }
    
    func writeUserScore(score: Int, username: String?){
        let db = Firestore.firestore()
        //db.collection(K_COLLECTION_SCORES).addDocument(data: ["score":3, "username":"Adria"])
        
        let userId = Preferences().getUserID()
        db.collection(K_COLLECTION_SCORES).addDocument(data: ["score":score, "username":username ?? "", "userId":userId])
    }
    
    func getScores(completion: @escaping([String])->(Void)){
        var scores: Array<String> = Array()
        let db = Firestore.firestore()
        
        db.collection("scores").order(by: "score", descending: true).limit(to: 6)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let username = document.get("username") ?? "no-username"
                        let currentScore = document.get("score") ?? "no-score"
                        scores.append("\(username) : \(currentScore)")
                    }
                    
                    completion(scores)
                }
        }
    }
    
    func updateUserScore(score: Int, username: String?){
        let db = Firestore.firestore()
        let userId = Preferences().getUserID()
        db.collection(K_COLLECTION_SCORES).document(userId).setData(["score":score, "username":username ?? "", "userId":userId], merge: true)
        
        //si no existeix el crearà, i si existeix ho actualitzarà. El merge es per mantenir qualsevol altra informació que hi havia al document
    }
    
    func getUserScore(){
        let db = Firestore.firestore()
        db.collection(K_COLLECTION_SCORES).whereField("score",isGreaterThan: 0).getDocuments{(snapshot,error) in
            snapshot?.documents.forEach({
                print($0.data())
            })
        }
    }
    
    func deleteScores() {
        let db = Firestore.firestore()
        //això borra totes les scores
        db.collection(K_COLLECTION_SCORES).document().delete()
        
    }
}
