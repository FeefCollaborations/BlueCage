import UIKit

class ConversationListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var sortedConversations: [Conversation] {
        return User.loggedInUser.conversations.sorted(by: { (conversation1, conversation2) -> Bool in
            guard let date1 = conversation1.latestMessageDate else {
                return true
            }
            guard let date2 = conversation2.latestMessageDate else {
                return false
            }
            return date1 > date2
        })
    }
    
    @IBOutlet var refreshButton: RefreshButton!
    @IBOutlet var tableView: UITableView!
    
    func conversations() -> [Conversation] {
        var conversations = [Conversation]()
        for index in 0...(arc4random() % 3 + 2) {
            conversations.append(Conversation.dummy(at: Int(index)))
        }
        return conversations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        User.loggedInUser.conversations = conversations()
        User.loggedInUser.lastConversationsRefreshDate = sortedConversations.first!.lastRefreshDate
        refreshPrompt()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "NavBarLogo"))
    }
    
    private func refreshPrompt() {
        UIView.performWithoutAnimation {
            navigationItem.prompt = "Last refreshed: \(DateFormatter.standard.string(from: User.loggedInUser.lastConversationsRefreshDate))"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tableView.reloadData()
    }
    
    @IBAction func refresh() {
        refreshButton.toggleState()
        // TODO: Load stuff from network
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshButton.toggleState()
            let randomIndex = Int(arc4random()) % User.loggedInUser.conversations.count
            let refreshDate = Date()
            var updatedConversations = [Conversation]()
            for index in 0..<User.loggedInUser.conversations.count {
                var conversation = User.loggedInUser.conversations[index]
                if index == randomIndex {
                    conversation.messages.append(Message(text: "Dober dan! What's goooooooood!?!", sendDate: refreshDate, sender: conversation.recipient, isLiked: false, id: NSUUID().uuidString))
                    conversation.unreadCount += 1
                }
                conversation.lastRefreshDate = refreshDate
                updatedConversations.append(conversation)
            }
            User.loggedInUser.conversations = updatedConversations
            User.loggedInUser.lastConversationsRefreshDate = refreshDate
            self.refreshPrompt()
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let conversation = sortedConversations[indexPath.row]
        let navigationController = UINavigationController(rootViewController: ConversationViewController(conversation))
        present(navigationController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ConversationTableViewCell.reuseIdentifier
        tableView.register(ConversationTableViewCell.nib, forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ConversationTableViewCell
        ConversationTableViewCellDecorator.decorate(cell, with: sortedConversations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedConversations.count
    }
}
