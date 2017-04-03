import UIKit

struct MessageCollectionViewCellDecorator {
    static func decorate(_ cell: MessageCollectionViewCell, with message: Message) {
        cell.messageLabel.text = message.text
        cell.anchorButton.isSelected = message.isLiked
    }
}
