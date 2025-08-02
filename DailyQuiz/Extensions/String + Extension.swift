import Foundation

import Foundation

extension String {
    var htmlUnescaped: String {
        guard let data = self.data(using: .utf8) else { return self }

        if let attributed = try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        ) {
            return attributed.string
        } else {
            return self
        }
    }
}
