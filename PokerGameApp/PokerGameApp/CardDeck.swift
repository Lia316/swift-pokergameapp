//
//  CardDeck.swift
//  PokerGameApp
//
//  Created by Lia on 2021/02/17.
//

import Foundation

class CardDeck {
    private(set) var cards = [Card]()
    private let initialCards: [Card]
    
    init() {
        for shape in Shape.allCases {
            for rank in Rank.allCases {
                let card = Card(shape: shape, rank: rank)
                self.cards.append(card)
            }
        }
        self.initialCards = self.cards
    }
    
    func count() -> Int {
        return cards.count
    }
    
    func shuffle() {
        cards.shuffle()
    }
    
    func takeOutCard() -> Card? {
        return cards.count != 0 ? cards.removeFirst() : nil
    }
    
    func reset() {
        cards = initialCards
    }
}
