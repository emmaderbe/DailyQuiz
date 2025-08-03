import UIKit

final class HistoryEmptyView: UIView {
    // MARK: - UI Components
    private let backgroundView = BackgroundViewFactory.createSmallBackView()
    private let stack = StackFactory.createVerticalStack(with: 40)
    private let messageLabel = LabelFactory.createLabel(with: .regular,
                                                        and: 20)
    
    private let startButton = CustomButton(title: "Начать викторину",
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
private extension HistoryEmptyView {
    func setupUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(stack)
        [messageLabel,
         startButton].forEach { stack.addArrangedSubview($0) }
    }

    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 32),
            stack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
            stack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -32)
        ])
    }
}

// MARK: - Actions
private extension HistoryEmptyView {
    func addTarget() {
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }
    @objc func startTapped() {
        onStartTapped?()
    }
}

// MARK: - Public functions
extension HistoryEmptyView {
    func setupMessage(with text: String) {
        messageLabel.text = text
    }
}
