import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    
    @IBAction func logout() {
        let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.prompt = nil
    }
    
    override func viewDidLoad() {
        nameLabel.text = User.loggedInUser.name
        idLabel.text = User.loggedInUser.id
    }
}
