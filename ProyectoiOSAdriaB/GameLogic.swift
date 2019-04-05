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

protocol GameLogicDelegate: class {
    func cardUntapped(idCard:Int)       //la tornem a deixar a l'estat origina (sense veure la imatge)
    func cardTapped(idCard:Int, newTexture:String)         //girada per primer cop
    func gameFinished()
}

class GameLogic {
    var delegate: GameLogicDelegate?
    var cards = [Card]()
    var points = 0
    var selectedCard: Card? //the card we have currently selected
    var gameFinished = false
    
    let textureNames = ["card1","card2","card3","card4","card1","card2","card3","card4"] //testing
    //let textureNames = ["testA","testB","testC","testD","testE","testF","testG","testH"]
    
    var level = Level.easy
    
    func start(){
        
        let texturesShuffled = textureNames.shuffled()
        let currentTextures = texturesShuffled.prefix(upTo: level.getNumberOfCards()/2) //We divide in 2 because each card will have an identical match
        
        //make a duplicate for each card
        var cardId = 0
        for cardText in currentTextures{
            cards.append(Card(cardId,   cardId+1,   cardText))
            cards.append(Card(cardId+1, cardId,     cardText))
            cardId += 2
        }
        
        cards.shuffle() //put all cards in a random order
    
        //DEBUG
        print("cards are")
        for card in cards{
            print("card "+card.textureFront)
        }
        
    }
    
    init(){
        
    }
    
    func selectCard(cardInd:Int){
        let currentCard = getCard(id: cardInd)
        if(currentCard.state == CardState.facingDown){
            currentCard.state = CardState.facingUp
            
            //If we had a selected card
            if let selected_card = self.selectedCard{
                //it's a match!
                if(selectedCard?.pairId == currentCard.id){
                    points += 1
                    currentCard.state = CardState.matched
                    selected_card.state = CardState.matched
                } else{
                    currentCard.state = CardState.facingDown
                    selected_card.state = CardState.facingDown
                    delegate?.cardUntapped(idCard: currentCard.id)
                }
                self.selectedCard = nil
                
            // if we had nothing selected
            } else{
                self.selectedCard = cards[cardInd]
            }
            delegate?.cardTapped(idCard: currentCard.id, newTexture: currentCard.textureFront)
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
    
    func getCard(id:Int) -> Card{
        var thecard = Card()
        for card in cards{
            if(card.id == id){
                thecard = card
            }
        }
        return thecard
    }
}
