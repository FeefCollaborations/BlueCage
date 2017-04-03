import Foundation
import GameKit

struct User: Equatable {
    var name: String
    var id: String
    var email: String
    var password: String
    var conversations: [Conversation]
    var lastConversationsRefreshDate: Date
    
    static let numberOfConversations = arc4random() % 6 + 2
    
    static let dummyNames = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: ["Feef Anthony", "Deb Simmons", "Doris Zivalj", "Bruna Bajic", "Aditya Girl", "Tihomir Zivalj", "Neno Bajic", "Zana Bajic"]) as! [String]
    
    static func dummy(at index: Int = Int(arc4random())) -> User {
        return User(name: dummyNames[index % dummyNames.count], id: "\(index)", email: "email", password: "password", conversations: [], lastConversationsRefreshDate: Date())
    }
    
    static var loggedInUser: User = User(name: "It's me!", id: NSUUID().uuidString, email: "myEmail", password: "myPassword", conversations: [], lastConversationsRefreshDate: Date())
}

func ==(lhs:User, rhs: User) -> Bool {
    return lhs.id == rhs.id
}
