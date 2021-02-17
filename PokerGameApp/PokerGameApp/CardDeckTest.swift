//
//  CardDeckTest.swift
//  PokerGameApp
//
//  Created by Lia on 2021/02/17.
//

import Foundation

struct CardDeckTest {
    var cardDeck = CardDeck()
    
    func testCountCard() {
        print("> 카드 개수: ", cardDeck.count(), "\n")
    }
    
    func testShuffle() {
        cardDeck.shuffle()
        print("> 카드 섞기:\n", cardDeck.cards, "\n")
    }
    
    func testTakeOutCard() {
        
        print("> 카드 하나 뽑기")
        if let card = cardDeck.takeOutCard() { print(card) }
        print("> 남은 카드 덱:\n", cardDeck.cards)
        print("총 \(cardDeck.count())장의 카드가 남아있습니다 \n")
    }
    
    func testReset() {
        cardDeck.reset()
        print("> 카드 초기화 \n카드 전체를 초기화했습니다.\n", cardDeck.cards, "\n")
    }
}

func runCardDeckTest(){
    let test = CardDeckTest()
    test.testReset()
    test.testCountCard()
    test.testShuffle()
    test.testTakeOutCard()
    test.testTakeOutCard()
    test.testCountCard()
    test.testShuffle()
    test.testReset()
}
