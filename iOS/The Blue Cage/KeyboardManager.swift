import UIKit

class KeyboardManager: NSObject {
    typealias KeyboardUpdateBlock = (CGRect) -> ()
    var onShow: KeyboardUpdateBlock?
    var onHide: KeyboardUpdateBlock?
    var onChangeFrame: KeyboardUpdateBlock?
    
    init(onShow: KeyboardUpdateBlock? = nil, onHide: KeyboardUpdateBlock? = nil, onChangeFrame: KeyboardUpdateBlock? = nil) {
        self.onShow = onShow
        self.onHide = onHide
        self.onChangeFrame = onChangeFrame
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(willShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willChangeFrame), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func willShow(notification: Notification) {
        getFrame(from: notification, andCall: onShow)
    }
    
    func willHide(notification: Notification) {
        getFrame(from: notification, andCall: onHide)
    }
    
    func willChangeFrame(notification: Notification) {
        getFrame(from: notification, andCall: onChangeFrame)
    }
    
    func getFrame(from notification: Notification, andCall method: KeyboardUpdateBlock?) {
        guard let frame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        method?(frame)
    }
}
