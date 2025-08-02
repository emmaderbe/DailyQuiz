import UIKit

// MARK: - CustomButtonState
enum CustomButtonState {
    case disabled
    case active
    case white
}

final class CustomButton: UIButton {
    // MARK: - Private properties
    private var currentStyle: CustomButtonState = .active

    // MARK: - Init
    init(title: String,
         style: CustomButtonState = .active) {
        super.init(frame: .zero)
        self.setTitle(title.uppercased(), for: .normal)
        setupUI()
        setupConstraints()
        applyStyle(style)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension CustomButton {
    func setupUI() {
        self.titleLabel?.font = UIFont(name: Font.black.rawValue,
                                       size: 16)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }

    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 280).isActive = true
    }
}

// MARK: - Public functions
extension CustomButton {
    // Изменяет визуальный стиль к кнопке в зависимости от её состояния
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

