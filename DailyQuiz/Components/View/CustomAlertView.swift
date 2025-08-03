import UIKit

final class CustomAlertView: UIView {
    // MARK: - UI Components
    private let backgroundView = BackgroundViewFactory.createSmallBackView()
    private let fisrstStack = StackFactory.createVerticalStack(with: 40)
    private let secondStack = StackFactory.createVerticalStack(with: 12)
    private let titleLabel = LabelFactory.createLabel(with: .bold,
                                                        and: 24)
    private let messageLabel = LabelFactory.createLabel(with: .regular,
                                                        and: 16)
    
    private let startButton = CustomButton(title: "Хорошо",
                                           style: .active)
    
    // MARK: - Public сallback
    var onStartTapped: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        addTarget()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension CustomAlertView {
    func setupUI() {
        backgroundColor = AppColors.black.withAlphaComponent(0.3)
        addSubview(backgroundView)
        backgroundView.addSubview(fisrstStack)
        [secondStack,
         startButton].forEach { fisrstStack.addArrangedSubview($0) }
        [titleLabel,
         messageLabel].forEach({ secondStack.addArrangedSubview($0)} )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 360),

            fisrstStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 32),
            fisrstStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            fisrstStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            fisrstStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -32)
        ])
    }
}

// MARK: - Actions
private extension CustomAlertView {
    func addTarget() {
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }
    @objc func startTapped() {
        onStartTapped?()
    }
}

// MARK: - Public functions
extension CustomAlertView {
    func setupMessage(with title: String,
                      and message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
}
