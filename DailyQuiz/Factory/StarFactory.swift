import UIKit

enum StarType {
    case active
    case inactive
}

struct StarFactory {
    static func createStars(count: Int, max: Int = 5) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillEqually
        
        for i in 0..<max {
            let type: StarType = i < count ? .active : .inactive
            let starView = makeStarView(type: type)
            stack.addArrangedSubview(starView)
        }
        
        return stack
    }
}

private extension StarFactory {
    static func makeStarView(type: StarType) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = imageForType(type)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return imageView
    }
    
    
    static func imageForType(_ type: StarType) -> UIImage? {
        switch type {
        case .active:
            return UIImage(named: "starActive")
        case .inactive:
            return UIImage(named: "starInactive")
        }
    }
}
