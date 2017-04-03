import Foundation

enum Result<SuccessType> {
    case success(SuccessType)
    case failure
}

protocol NetworkTask {
    associatedtype Value
    func resume(completion: (Result<Value>) -> ())
}
