import UIKit

class ConversationViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate {
    var conversation: Conversation
    lazy var refreshButton: RefreshButton = {
        return RefreshButton.new(target: self, action: #selector(refresh))
    }()
    let keyboardManager = KeyboardManager()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var inputTextView: UITextView!
    @IBOutlet var textViewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var textViewContainerToBottomConstraint: NSLayoutConstraint!
    
    init(_ conversation: Conversation) {
        self.conversation = conversation
        super.init(nibName: nil, bundle: nil)
        automaticallyAdjustsScrollViewInsets = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: Fire off network call to say conversation was read
        conversation.unreadCount = 0
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .BCBrown
        let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        navigationItem.setLeftBarButton(closeButton, animated: false)
        navigationItem.setRightBarButton(refreshButton, animated: false)
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .black
        refreshPrompt()
        navigationItem.title = conversation.recipient.name
        
        keyboardManager.onShow = keyboardUpdated(to:)
        keyboardManager.onHide = keyboardUpdated(to:)
        keyboardManager.onChangeFrame = keyboardUpdated(to:)
    }
    
    private func refreshPrompt() {
        UIView.performWithoutAnimation {
            navigationItem.prompt = "Last refreshed: \(DateFormatter.standard.string(from: conversation.lastRefreshDate))"
        }
    }
    
    func keyboardUpdated(to frame: CGRect) {
        let verticalKeyboardOnScreen = frame.onScreenRect.height
        textViewContainerToBottomConstraint.constant = verticalKeyboardOnScreen
        // TODO: Move messages along with rest of screen
    }
    
    func close() {
        if let index = User.loggedInUser.conversations.index(of: conversation) {
            User.loggedInUser.conversations[index] = conversation
        }
        dismiss(animated: true)
    }
    
    func refresh() {
        refreshButton.toggleState()
        // TODO: Fire off network call to retrieve messages
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshButton.toggleState()
            self.conversation.messages.append(Message(text: "Dober dan! What's goooooooood!?!", sendDate: Date(), sender: self.conversation.recipient, isLiked: false, id: NSUUID().uuidString))
            self.conversation.lastRefreshDate = Date()
            self.refreshPrompt()
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func sendMessage() {
        guard
            let text = inputTextView.text,
            !text.characters.isEmpty
        else {
            return
        }
        inputTextView.text = ""
        // TODO: Fire off network call to send new message
        conversation.messages.append(Message(text: text, sendDate: Date(), sender: User.loggedInUser, isLiked: false, id: NSUUID().uuidString))
        collectionView.reloadData()
    }
    
    func message(for indexPath: IndexPath) -> Message {
        return conversation.sortedMessages[indexPath.row]
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conversation.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var message = self.message(for: indexPath)
        let messageIsFromLoggedInUser = message.isFromLoggedInUser
        let reuseIdentifier = MessageCollectionViewCell.reuseIdentifier(forSender: messageIsFromLoggedInUser)
        collectionView.register(MessageCollectionViewCell.nib(forSender: messageIsFromLoggedInUser), forCellWithReuseIdentifier: reuseIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCollectionViewCell
        MessageCollectionViewCellDecorator.decorate(cell, with: message)
        cell.onAnchorTap = {
            guard let index = self.conversation.messages.index(of: message) else {
                // WARNING: Unable to find message that was liked
                return
            }
            cell.anchorButton.isSelected = !cell.anchorButton.isSelected
            message.isLiked = cell.anchorButton.isSelected
            self.conversation.messages[index] = message
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = self.message(for: indexPath)
        let width = view.bounds.width
        let height = MessageCollectionViewCell.desiredHeight(for: message.text, in: collectionView)
        NSLog("height is \(height)")
        return CGSize(width: width, height: height)
    }
    
    // MARK: - UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let isReturn = text == "\n"
        if isReturn {
            textView.resignFirstResponder()
        }
        return !isReturn
    }
}
