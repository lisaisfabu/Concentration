//
//  Concentration.swift
//  Concentration
//
//  Created by Lisa Liu on 2/17/19.
//  Copyright © 2019 Lisa Liu. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfFaceUp: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfFaceUp, matchIndex != index {
                //check if card matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfFaceUp = nil
            } else {
                //either no cards or 2 cards are faced up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfFaceUp = index
            }
        }
    }
    
    func restart(){
        indexOfFaceUp = nil
        cards = []
    }
    
    init(numPairs: Int) {
        for _ in 1...numPairs {
            let card = Card()
            cards += [card, card]
        }
        //TODO: shuffle cards
        cards.shuffle()
    }
}
