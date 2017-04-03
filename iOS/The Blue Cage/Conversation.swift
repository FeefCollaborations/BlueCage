import Foundation

struct Conversation: Equatable {
    var recipient: User
    var id: String
    var messages: [Message]
    var unreadCount: Int
    var latestMessageDate: Date? {
        return sortedMessages.last?.sendDate
    }
    var sortedMessages: [Message] {
        return messages.sorted { $0.sendDate < $1.sendDate }
    }
    var lastRefreshDate: Date
    
    private static func sort(_ messages: [Message]) -> [Message] {
         return messages.sorted { $0.sendDate < $1.sendDate }
    }
    
    static func dummy(at index: Int) -> Conversation {
        let max = arc4random() % 10
        var messages = [Message]()
        let recipient = User.dummy(at: index)
        for _ in 0...max {
            let sendFromSelf = arc4random() % 2 == 0
            messages.append(Message.dummy(with: sendFromSelf ? User.loggedInUser : recipient))
        }
        let sortedMessages = sort(messages)
        let refreshDate = sortedMessages.last?.sendDate.addingTimeInterval((Double)(Int(arc4random()) % 10000)) ?? Date()
        return Conversation(recipient: recipient, id: NSUUID().uuidString, messages: messages, unreadCount: 0, lastRefreshDate: refreshDate)
    }
}

func ==(lhs: Conversation, rhs: Conversation) -> Bool {
    return lhs.id == rhs.id
}
