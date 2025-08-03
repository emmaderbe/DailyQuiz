import UIKit

enum ResultIcon: String {
    case correct = "correct"
    case incorrect = "incorrect"
}

struct ImageFactory {
    static func createLogoImage() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
    
    static func createIcon(with result: ResultIcon) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: result.rawValue)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
}
