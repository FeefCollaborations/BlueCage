import Foundation

class LoginNetworkTask: URLSessionDataTask, NetworkTask {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func resume(completion: (Result<User>) -> ()) {
        // TODO: Fire off network call to attempt login
        completion(.success(User.loggedInUser))
    }
}
