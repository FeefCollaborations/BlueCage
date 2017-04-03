import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    let keyboardManager = KeyboardManager()
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var stackViewVerticalConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
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
            let name = nameTextField.text,
            name.characters.isEmpty == false,
            let email = emailTextField.text,
            email.characters.isEmpty == false,
            let password = passwordTextField.text,
            password.characters.isEmpty == false
        else {
            // TODO: Show alert
            return
        }
        let signUpTask = SignUpNetworkTask(name: name, email: email, password: password)
        // TODO: Show "loading" alert
        signUpTask.resume() { [weak self] result in
            // TODO: Show "loading" alert
            switch result {
                case .success(let user):
                    self?.successfullyCreatedUser(user)
                case .failure:()
                    // TODO: Show failure to create account alert
            }
        }
    }
    
    func successfullyCreatedUser(_: User) {
        // TODO: Write details of logged in user to user defaults
        // TODO: Show prompt letting user know:
        //  - they're logged in
        //  - what their user ID is
        //  - that they can find their user ID in settings
        userAcknowledgedSignUp()
    }
    
    func userAcknowledgedSignUp() {
        performSegue(withIdentifier: "ToConversationsList", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
