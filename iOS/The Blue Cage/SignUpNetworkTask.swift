import Foundation

class SignUpNetworkTask: URLSessionDataTask {
    let name: String
    let email: String
    let password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func resume(completion: (Result<User>) -> ()) {
        // TODO: Fire off network call to create account
        completion(.success(User.loggedInUser))
    }
}
