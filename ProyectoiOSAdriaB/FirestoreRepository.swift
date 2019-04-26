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
    
    func writeUserScore(score: Int, username: String?){
        let db = Firestore.firestore()
        //db.collection(K_COLLECTION_SCORES).addDocument(data: ["score":3, "username":"Adria"])
        
        let userId = Preferences().getUserID()
        db.collection(K_COLLECTION_SCORES).addDocument(data: ["score":score, "username":username ?? "", "userId":userId])
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
