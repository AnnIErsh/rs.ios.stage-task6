import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public mutating func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var newCards:[Card] = []
        let sortedValues: [Value] = values.sorted(by: {
            (a, b) in
            return a.rawValue < b.rawValue
        })
        let sortedSuets: [Suit] = suits.sorted(by: {
            (a, b) in
            return a.rawValue < b.rawValue
        })
        for val in sortedValues
        {
            for suit in sortedSuets
            {
                let card = Card(suit: suit, value: val, isTrump: false)
                newCards.append(card)
            }
        }
        return newCards
    }

    public mutating func shuffle() {
        let mix:[Card] = cards.shuffled()
        cards = mix
    }

    public mutating func defineTrump() {
        if (!cards.isEmpty)
        {
            trump = cards.last?.suit
            var i = 0
            while (i < cards.count)
            {
                if (cards[i].suit == trump)
                {
                    cards[i].isTrump = true
                }
                i += 1
            }
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        for player in players
        {
            var initialCards:[Card] = []
            var i = 6
            while (i > 0 && !cards.isEmpty && player.hand == nil)
            {
                
                initialCards.append(cards[i])
                cards.removeLast()
                i -= 1
            }
            player.hand = initialCards
        }
    }

    public mutating func setTrumpCards(for suit: Suit) {
        var i = 0
        while (i < cards.count)
        {
            if (cards[i].suit == suit)
            {
                cards[i].isTrump = true
            }
            i += 1
        }
    }
}

