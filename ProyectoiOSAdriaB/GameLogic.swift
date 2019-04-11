//
//  GameLogic.swift
//  ProyectoiOSAdriaB
//
//  Created by Adrià Biarnés Belso on 21/03/2019.
//  Copyright © 2019 Adrià Biarnés Belso. All rights reserved.
//

import Foundation

enum Level: Int {
    case easy = 12
    case medium = 20
    case hard = 30  //test values
    func getNumberOfCards() -> Int {
        return self.rawValue
    }
}

protocol GameLogicDelegate: class {
    func cardUntapped(idCard:Int)       //la tornem a deixar a l'estat origina (sense veure la imatge)
    func cardTapped(idCard:Int, newTexture:String)         //girada per primer cop
    func gameFinished()
    func pointsAdded(totalPoints:Int)
}

class GameLogic {
    var delegate: GameLogicDelegate?
    var cards = [Card]()
    
    var points = 0
    var currentStreak = 0
    var previousSelectedCard: Card? //the card we have currently selected
    var gameFinished = false
    
    let MATCH_REWARD = 2
    
    let textureNames = ["Card0","Card1","Card2","Card3","Card4","Card5","Card6","Card7","Card8","Card9","Card10","Card11","Card12","Card13","Card14"] //testing
    //let textureNames = ["testA","testB","testC","testD","testE","testF","testG","testH"]
    
    var level = Level.easy
    
    func start(startdifficulty:Level){
        
        level = startdifficulty
        let currentTextures = textureNames.prefix(upTo: level.getNumberOfCards()/2) //We divide in 2 because each card will have an identical match
        
        //make a duplicate for each card
        var cardId = 0
        for cardText in currentTextures{
            cards.append(Card(cardId,   cardId+1,   cardText))
            cards.append(Card(cardId+1, cardId,     cardText))
            cardId += 2
        }
        
        cards.shuffle() //put all cards in a random order
        
    }
    
    init(){
        
    }
    
    func selectCard(cardInd:Int){
        let currentCard = getCard(id: cardInd)
        if(currentCard.state == CardState.facingDown){
            currentCard.state = CardState.facingUp
            
            //If we had a selected card
            if let selected_card = self.previousSelectedCard{
                //it's a match!
                if(previousSelectedCard?.pairId == currentCard.id){
                    currentCard.state = CardState.matched
                    selected_card.state = CardState.matched
                    score()
                } else{
                    currentStreak = 0
                    print("currentstreak \(currentStreak))")
                    
                    currentCard.state = CardState.facingDown
                    selected_card.state = CardState.facingDown
                    delegate?.cardUntapped(idCard: currentCard.id)
                    delegate?.cardUntapped(idCard: selected_card.id)
                }
                self.previousSelectedCard = nil
                
            // if we had nothing selected
            } else{
                self.previousSelectedCard = currentCard
            }
            delegate?.cardTapped(idCard: currentCard.id, newTexture: currentCard.textureFront)
        }
        checkGameFinishied()
    }
    
    func pointsEarned(gainedPoints:Int){
        points += gainedPoints
        delegate?.pointsAdded(totalPoints: points)
        //call points label delegate
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

    //we scored some points
    func score(){
        print("scoring")
        
        print("currentstreak \(currentStreak))")
        currentStreak += 1
        print("currentstreak \(currentStreak))")
        points += currentStreak * MATCH_REWARD
        pointsEarned(gainedPoints: points)
        
        if(currentStreak > 0){
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
