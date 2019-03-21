//
//  GameLogic.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 21/03/2019.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation

enum Level: Int {
    case easy = 4
    case medium = 8
    case hard = 16  //test values
    func getNumberOfCards() -> Int {
        return self.rawValue
    }
}

class GameLogic {
    var cards = [Card]()
    var points = 0
    var selectedCard: Card? //the card we have currently selected
    
    let textureNames = ["testA","testB","testC","testD","testE","testF","testG","testH"]
    
    var level = Level.easy
    
    func start(){
        
        let texturesShuffled = textureNames.shuffled()
        let currentTextures = texturesShuffled.prefix(upTo: level.getNumberOfCards()/2) //ArraySlice
        
        var cardId = 0
        for cardText in currentTextures{
            cards.append(Card(cardId,cardText))
            cards.append(Card(cardId+1,cardText))
            cardId += 2
        }
        
        cards.shuffle() //put all cards in a random order (
        
        //place them in the scene?
    }
    
    init(){
        
    }
    
}
