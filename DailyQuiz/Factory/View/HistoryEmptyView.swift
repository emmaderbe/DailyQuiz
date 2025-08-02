import UIKit

final class HistoryEmptyView: UIView {
    // MARK: - UI Components
    private let backgroundView = BackgroundViewFactory.createSmallBackView()
    
    private let messageLabel = LabelFactory.createLabel(with: .regular,
                                                        and: 20)
    
    private let startButton = CustomButton(title: "Начать викторину",
                                           style: .active)
    
    // MARK: - Public Callback
    var onStartTapped: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HistoryEmptyView {
    func setupUI() {
        addSubview(backgroundView)
        
        [messageLabel,
         startButton].forEach { backgroundView.addSubview($0) }
    }

    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            messageLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 32),
            messageLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
            messageLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
            
            startButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 40),
            startButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -32)
        ])
    }

    @objc func startTapped() {
        onStartTapped?()
    }
}

extension HistoryEmptyView {
    func setupMessage(with text: String) {
        messageLabel.text = text
    }
}
