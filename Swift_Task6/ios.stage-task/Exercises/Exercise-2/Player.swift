//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        if (hand != nil)
        {
            if let cards = hand
            {
                for mycard in cards
                {
                    if (mycard.value.rawValue == card.value.rawValue)
                    {
                        return true
                    }
                }
            }
        }
        return false
    }

    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        if (!table.isEmpty)
        {
            for item in table
            {
                if let val = hand
                {
                    for card in val
                    {
                        if (item.value.value == card.value || item.key.value == card.value)
                        {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
}
