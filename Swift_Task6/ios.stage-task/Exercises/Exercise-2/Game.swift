//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        if (players.count > 1 && players.count <= 6)
        {
            var whoIsFirst: Player?
            var minTrump = players[0].hand![0].value.rawValue
            for player in players
            {
                if let hand = player.hand
                {
                    var i = 0
                    while (i < 6)
                    {
                        if (hand[i].isTrump)
                        {
                            if (hand[i].value.rawValue <= minTrump)
                            {
                                minTrump = hand[i].value.rawValue
                                whoIsFirst = player
                            }
                        }
                        i += 1
                    }
                }
            }
            if (whoIsFirst != nil)
            {
                return whoIsFirst
            }
        }
        return nil
    }
}
