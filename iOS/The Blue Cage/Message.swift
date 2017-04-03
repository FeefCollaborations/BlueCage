import Foundation

struct Message: Equatable {
    var text: String
    var sendDate: Date
    var sender: User
    var isLiked: Bool
    var id: String
    
    var isFromLoggedInUser: Bool {
        return sender == User.loggedInUser
    }

    static func dummy(with user: User = User.loggedInUser) -> Message {
        var randomText = ""
        let max = arc4random() % 10
        for _ in 0...max {
            randomText += "Another bit of random text. "
        }
        let date = Date(timeIntervalSinceNow: -(Double(arc4random() % 1000000)))
        return Message(text: randomText, sendDate: date, sender: user, isLiked: arc4random() % 5 == 0, id: NSUUID().uuidString)
    }
}

func ==(lhs: Message, rhs: Message) -> Bool {
    return lhs.id == rhs.id
}
