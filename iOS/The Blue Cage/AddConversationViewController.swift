import UIKit

class AddConversationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var stackViewVerticalConstraint: NSLayoutConstraint!
    let keyboardManager = KeyboardManager()
    
    @IBAction func startConversation() {
        // TODO: Fire off request to backend to create conversation between this user and that one.
        // TODO: Show "loading" alert
        User.loggedInUser.conversations.append(Conversation(recipient: User.dummy(), id: NSUUID().uuidString, messages: [], unreadCount: 0, lastRefreshDate: Date()))
        let _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardManager.onShow = keyboardUpdated(to:)
        keyboardManager.onHide = keyboardUpdated(to:)
        keyboardManager.onChangeFrame = keyboardUpdated(to:)
    }
    
    func keyboardUpdated(to frame: CGRect) {
        stackViewVerticalConstraint.constant = -frame.onScreenRect.height / 2
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
