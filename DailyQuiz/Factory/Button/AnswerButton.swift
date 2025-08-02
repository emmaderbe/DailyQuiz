import UIKit

enum QuizAnswerState {
    case defaultChoice
    case selected
    case correct
    case incorrect
}

final class AnswerButton: UIButton {
    // MARK: - UI сomponents
    private let iconImageView = UIImageView()
    
    // MARK: - Init
    init(title: String,
         state: QuizAnswerState = .defaultChoice) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupUI()
        setupConstraints()
        applyState(state)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension AnswerButton {
    func setupUI() {
        self.titleLabel?.font = UIFont(name: Font.regular.rawValue,
                                       size: 14)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.contentHorizontalAlignment = .left
        self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                            left: 52,
                                            bottom: 0,
                                            right: 0)

        addSubview(iconImageView)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            widthAnchor.constraint(greaterThanOrEqualToConstant: 280),
            
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

// MARK: - Public functions
extension AnswerButton {
    // Изменяет визуальный стиль кнопки в зависимости от состояния
    func applyState(_ state: QuizAnswerState) {
        switch state {
        case .defaultChoice:
            backgroundColor = AppColors.lightGray
            setTitleColor(AppColors.black, for: .normal)
            layer.borderWidth = 0
            iconImageView.image = UIImage(named: "defaultChoice")
            
        case .selected:
            backgroundColor = .clear
            setTitleColor(AppColors.darkPurple, for: .normal)
            layer.borderColor = AppColors.darkPurple.cgColor
            layer.borderWidth = 1
            iconImageView.image = UIImage(named: "selected")
            
        case .correct:
            backgroundColor = .clear
            setTitleColor(AppColors.green, for: .normal)
            layer.borderColor = AppColors.green.cgColor
            layer.borderWidth = 1
            iconImageView.image = UIImage(named: "correct")
            
        case .incorrect:
            backgroundColor = .clear
            setTitleColor(AppColors.red, for: .normal)
            layer.borderColor = AppColors.red.cgColor
            layer.borderWidth = 1
            iconImageView.image = UIImage(named: "incorrect")
        }
    }
}
