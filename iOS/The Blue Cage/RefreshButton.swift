import UIKit

class RefreshButton: UIBarButtonItem {
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    private lazy var activityIndicatorContainer: UIView = {
        let view = UIView()
        view.addSubview(self.activityIndicator)
        var frame = view.frame
        // WARNING: Magic number
        frame.size.width = 10
        view.frame = frame
        return view
    }()
    
    enum State {
        case refreshing
        case interactive
    }
    
    private var state: State = .interactive
    
    static func new(target: Any?, action: Selector?) -> RefreshButton {
        return RefreshButton(barButtonSystemItem: .refresh, target: target, action: action)
    }
    
    func toggleState() {
        update(to: state == .refreshing ? .interactive : .refreshing)
    }
    
    func update(to state: State) {
        guard state != self.state else {
            return
        }
        self.state = state
        self.customView = state == .refreshing ? activityIndicatorContainer : nil
    }
    
}
