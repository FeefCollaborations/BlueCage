import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    let keyboardManager = KeyboardManager()
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var stackViewVerticalConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
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
    
    @IBAction func validateAccountValues() {
        guard
            let email = emailTextField.text,
            email.characters.isEmpty == false,
            let password = passwordTextField.text,
            password.characters.isEmpty == false
            else {
                // TODO: Show alert
                return
        }
        let loginTask = LoginNetworkTask(email: email, password: password)
        // TODO: Show "loading" alert
        loginTask.resume() { [weak self] result in
            // TODO: Show "loading" alert
            switch result {
                case .success(let user):
                    self?.successfullyLoggedIn(with: user)
                case .failure:()
                    // TODO: Show failure to create account alert
            }
        }
    }
    
    func successfullyLoggedIn(with user: User) {
        // TODO: Write details of logged in user to user defaults
        performSegue(withIdentifier: "ToConversationsList", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
