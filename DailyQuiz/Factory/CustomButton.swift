import UIKit

enum CustomButtonState {
    case disabled
    case active
    case white
}

final class CustomButton: UIButton {

    private var currentStyle: CustomButtonState = .active

    init(title: String, style: CustomButtonState = .active) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        setupUI()
        setupConstraints()
        applyStyle(style)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomButton {
    func setupUI() {
        self.titleLabel?.font = UIFont(name: Font.black.rawValue, size: 16)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }

    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension CustomButton {
    func applyStyle(_ style: CustomButtonState) {
        self.currentStyle = style
        
        switch style {
        case .disabled:
            backgroundColor = AppColors.gray
            setTitleColor(AppColors.white, for: .normal)
            isEnabled = false
            
        case .active:
            backgroundColor = AppColors.primaryPurple
            setTitleColor(AppColors.white, for: .normal)
            isEnabled = true
            
        case .white:
            backgroundColor = AppColors.white
            setTitleColor(AppColors.darkPurple, for: .normal)
            isEnabled = true
        }
    }
}

