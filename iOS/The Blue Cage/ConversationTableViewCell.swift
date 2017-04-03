import UIKit

class ConversationTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ConversationTableViewCell"
    static let nib = UINib(nibName: "ConversationTableViewCell", bundle: nil)
    
    @IBOutlet var messageTextLabel: UILabel!
    @IBOutlet var senderLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var unreadBadgeLabel: BadgeSwift!
}
