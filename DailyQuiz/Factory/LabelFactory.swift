import UIKit

enum Font: String, Equatable {
    case bold = "Inter-Bold"
    case semibold = "Inter-SemiBold"
    case regular = "Inter-Regular"
    case black = "Inter-Black"
}

struct LabelFactory {
    static func createLabel(with font: Font, and size: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: font.rawValue, size: size)
        label.textAlignment = .center
        label.textColor = AppColors.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
