import UIKit

extension CGRect {
    var onScreenRect: CGRect {
        return self.intersection(UIScreen.main.bounds)
    }
}
