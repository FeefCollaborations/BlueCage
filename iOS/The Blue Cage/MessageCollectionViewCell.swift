import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    static func reuseIdentifier(forSender: Bool) -> String {
        return forSender ? "SenderMessageCollectionViewCell" : "ReceiverMessageCollectionViewCell"
    }
    static func nib(forSender: Bool) -> UINib {
        let nibName = reuseIdentifier(forSender: forSender)
        return UINib(nibName: nibName, bundle: nil)
    }
    // WARNING: Magic numbers! Must match up with nib(s)
    static let textBoxInsetSize = CGSize(width: 81, height: 24)
    static let messageLabelFont: UIFont = UIFont.systemFont(ofSize: 17)
    
    @IBOutlet var bubbleView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var anchorButton: UIButton!
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]!
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]!
    
    var onAnchorTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 12
        anchorButton.addTarget(self, action: #selector(anchorTapped), for: .touchUpInside)
    }
    
    static func desiredHeight(for text: String, in collectionView: UICollectionView) -> CGFloat {
        var maxSize = collectionView.bounds.size
        maxSize.width -= textBoxInsetSize.width
        let rect = (text as NSString).boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: messageLabelFont], context: nil)
        return ceil(rect.height) + textBoxInsetSize.height
    }
    
    func anchorTapped() {
        onAnchorTap?()
    }
}
