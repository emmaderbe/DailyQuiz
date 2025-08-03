import UIKit

struct BackButton {
    static func createBackButton(target: Any?,
                                 action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        let image = UIImage(named: "backArrow")
        button.setImage(image, for: .normal)
        button.tintColor = AppColors.white
        button.contentHorizontalAlignment = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(target,
                         action: action,
                         for: .touchUpInside)
        return button
    }
}

