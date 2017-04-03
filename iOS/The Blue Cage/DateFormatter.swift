import Foundation

extension DateFormatter {
    static let standard: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        return dateFormatter
    }()
}
