import UIKit

struct ConversationTableViewCellDecorator {
    static func decorate(_ cell: ConversationTableViewCell, with conversation: Conversation) {
        cell.messageTextLabel.text = conversation.sortedMessages.last?.text ?? NSLocalizedString("Start the conversation!", comment: "Prompt to ask the user to begin speaking with the other person in the conversation")
        let dateText: String
        if let date = conversation.latestMessageDate {
            dateText = DateFormatter.standard.string(from: date)
        } else {
            dateText = ""
        }
        let textColor = UIColor.BCBrown
        cell.timestampLabel.text = dateText
        cell.timestampLabel.textColor = textColor
        cell.senderLabel.text = conversation.recipient.name
        cell.senderLabel.textColor = textColor
        let unreadCount = conversation.unreadCount
        cell.unreadBadgeLabel.isHidden = unreadCount == 0
        cell.unreadBadgeLabel.text = unreadCount < 10 ? "\(unreadCount)" : "9+"
    }
}
