//
//  Hand.swift
//  CardGameApp
//
//  Created by 신한섭 on 2020/02/13.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class Hand{
    enum ResultPriority: Int{
        case noPair = 0, onePair, twoPair, triple, fourCard, straight
        
        func equal(num: Int) -> Bool{
            return self.rawValue == num
        }
    }
    
    private var cards: [Card] = [Card]()
    private var resultCardInfo: [Card] = [Card]()
    
    func append(card: Card){
        self.cards.append(card)
    }
    
    func removeAll(){
        self.cards.removeAll()
    }
    
    func forEachCardInHand(_ transform: (Card) -> ()){
        cards.forEach {
            transform($0)
        }
    }
    
    func result() -> ResultPriority{
        if checkStraight(cards: cards.sorted()){
            resultCardInfo.sort(by: >)
            return .straight
        }
        
        return checkSameCard(cards: cards.sorted())
    }
    
    func checkStraight(cards: [Card]) -> Bool{
        var previousCard = cards[0]
        var straightCount = 1
        var previousStraightCount = 0
        for cardIndex in 1..<cards.count{
            let nextCard = cards[cardIndex]
            if previousCard.isSerial(card: nextCard){
                resultCardInfo.append(previousCard)
                straightCount += 1
            } else{
                if previousStraightCount < straightCount{
                    previousStraightCount = straightCount
                }
                resultCardInfo.removeAll()
                straightCount = 1
            }
            previousCard = nextCard
        }
        
        resultCardInfo.reverse()
        return ResultPriority.straight.equal(num: straightCount > previousStraightCount ? straightCount : previousStraightCount)
    }
    
    func checkSameCard(cards: [Card]) -> ResultPriority{
        resultCardInfo.removeAll()
        var howMany = [Card : Int]()
        cards.forEach{
            if howMany[$0] == nil{
                howMany[$0] = 1
            } else{
                howMany.updateValue(howMany[$0]! + 1, forKey: $0)
            }
        }
        
        if howMany.values.contains(4){
            for (key,value) in howMany{
                if value == 4{
                    resultCardInfo.append(key)
                }
            }
            resultCardInfo.sort(by: >)
            return .fourCard
        } else if howMany.values.contains(3){
            for (key,value) in howMany{
                if value == 3{
                    resultCardInfo.append(key)
                }
            }
            resultCardInfo.sort(by: >)
            return .triple
        } else if howMany.values.contains(2){
            for (key,value) in howMany{
                if value == 2{
                    resultCardInfo.append(key)
                }
            }
            resultCardInfo.sort(by: >)
            return resultCardInfo.count == 2 ? .twoPair : .onePair
        }
        return .noPair
    }
}

extension Hand.ResultPriority: Comparable{
    static func < (lhs: Hand.ResultPriority, rhs: Hand.ResultPriority) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Hand: Comparable{
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.result() != rhs.result(){
            return lhs.result() < rhs.result()
        } else{
            for index in 0..<lhs.resultCardInfo.count{
                if lhs.resultCardInfo[index] != rhs.resultCardInfo[index]{
                    return lhs.resultCardInfo[index] < rhs.resultCardInfo[index]
                }
            }
            
            for index in 0..<lhs.cards.count{
                if lhs.cards[index] < rhs.cards[index]{
                    return lhs.cards[index] < rhs.cards[index]
                }
            }
        }
        return true
    }
    
    static func == (lhs: Hand, rhs: Hand) -> Bool {
        for index in 0..<lhs.cards.count{
            if lhs.cards[index] != rhs.cards[index]{
                return false
            }
        }
        return true
    }
}
