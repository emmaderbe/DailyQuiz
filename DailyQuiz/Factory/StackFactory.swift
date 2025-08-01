import UIKit

struct StackFactory {
    static func createVerticalStack(with spacing: CGFloat) -> UIStackView {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = spacing
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    static func createHorizontalStack(with spacing: CGFloat) -> UIStackView {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
