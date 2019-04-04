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
    var gameFinished = false
    
let textureNames = ["aCard","aCard","aCard","aCard","aCard","aCard","aCard","aCard"] //testing
    //let textureNames = ["testA","testB","testC","testD","testE","testF","testG","testH"]
    
    var level = Level.easy
    
    func start(){
        
        let texturesShuffled = textureNames.shuffled()
        let currentTextures = texturesShuffled.prefix(upTo: level.getNumberOfCards()/2) //We divide in 2 because each card will have an identical match
        
        //make a duplicate for each card
        var cardId = 0
        for cardText in currentTextures{
            cards.append(Card(cardId,cardText))
            cards.append(Card(cardId+1,cardText))
            cardId += 2
        }
        
        cards.shuffle() //put all cards in a random order
        
        //place them in the scene?
        
        //DEBUG
        print("cards are")
        for card in cards{
            print("card "+card.textureFront)
            
        }
        selectCard(cardInd: 0)
        selectCard(cardInd: 1)
        
    }
    
    init(){
        
    }
    
    func selectCard(cardInd:Int){
        if(cards[cardInd].state == CardState.facingDown){
            cards[cardInd].state = CardState.facingUp
            
            //If we had a selected card
            if let selected_card = self.selectedCard{
                //it's a match!
                if(selected_card.textureFront == cards[cardInd].textureFront){
                    points += 1
                    cards[cardInd].state = CardState.matched
                    selected_card.state = CardState.matched
                } else{
                    cards[cardInd].state = CardState.facingDown
                    selected_card.state = CardState.facingDown
                }
                self.selectedCard = nil
                
            // if we had nothing selected
            } else{
                self.selectedCard = cards[cardInd]
                
            }
        }
        checkGameFinishied()
    }
    
    func checkGameFinishied(){
        for card in cards{
            if(card.state != CardState.matched){
                break
            }
            gameFinished = true
            //TODO: show victory message screen or something
        }
    }
    
}
