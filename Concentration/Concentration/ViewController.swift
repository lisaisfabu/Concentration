//
//  ViewController.swift
//  Concentration
//
//  Created by Lisa Liu on 2/17/19.
//  Copyright © 2019 Lisa Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numPairs: numOfPairs)
    
    lazy var numOfPairs = ((cardButton.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButton: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButton.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("the card choosen isn't avaliable")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButton.indices {
            let button = cardButton[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6407066584, blue: 0.2928062677, alpha: 0) : #colorLiteral(red: 1, green: 0.6407066584, blue: 0.2928062677, alpha: 1)
            }
        }
    }
    
    // Chnage emojichoices to be a ref to a emoji_set which is used to update the cards
    // choice is only used to repopulate emoji_set
    
    var emojiSet = [
                    ["🐵", "🐸", "🐼", "🐹", "🐷", "🐮", "🦁", "🐨", "🦊"],
                    ["🍏", "🍎", "🍋", "🍐", "🍌", "🍉", "🍇", "🍓", "🥭"],
                    ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🥏", "🏓"],
                    ["🚗", "🚕", "🚙", "🚌", "🚎", "🚒", "🏎", "🚛", "🛵"],
                    ["🇦🇺", "🇧🇷", "🇬🇧", "🇧🇪", "🇦🇷", "🇮🇸", "🇯🇵", "🇳🇬", "🇨🇦"],
                    ["🥺", "🤪", "😚", "🤩", "🤗", "😳", "🥴", "😌", "🧐"]
                ]
    
    lazy var emojiChoices = emojiSet
    
    lazy var randRow = Int(arc4random_uniform(UInt32(emojiChoices.count)))
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[randRow].count)))
            emoji[card.identifier] = emojiChoices[randRow].remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
        //the if statement is same as that ^
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        //set flipcount to 0
        flipCount = 0
        
        //set the index of faceup to nil and remove all current cards in cards array
        game.restart()
        
        // reset dictionary of emoji's
        emoji = [Int:String]()
        
        // load emojichoices libaray into our emoji_set(temp var)
        emojiChoices = emojiSet
        
        //randomize the row
        randRow = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        
        //call the init from concentration and save it in game again so we can
        //start appending cards again
        game = Concentration(numPairs: numOfPairs)
        
        //update after appending
        updateViewFromModel()
    }

}
