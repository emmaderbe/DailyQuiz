import UIKit

final class MainView: UIView {
    // MARK: - UI Components
    private let historyButton = HistoryButton(title: "История")
    private let logoImage = ImageFactory.createLogoImage()
    private let backgroundView = BackgroundViewFactory.createBackView()
    private let verticalStack = StackFactory.createVerticalStack(with: 40)
    private let titleLabel = LabelFactory.createLabel(with: .bold, and: 28)
    private let startQuizButton = CustomButton(title: "Начать викторину")

    private let loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = AppColors.white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    private let errorLabel = LabelFactory.createLabel(with: .bold, and: 20)
    
    // MARK: - Public callback
    var onStartQuizTapped: (() -> Void)?
    var onHistoryTapped: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.primaryPurple
        setupView()
        setupConstraints()
        addTarger()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainView {
    func setupView() {
        self.backgroundColor = AppColors.primaryPurple
        errorLabel.textColor = AppColors.white
        errorLabel.isHidden = true
        
        [historyButton,
         logoImage,
         backgroundView,
         loader,
         errorLabel].forEach( { addSubview($0) } )
        
        [verticalStack].forEach( { backgroundView.addSubview($0) } )
        
        [titleLabel,
         startQuizButton].forEach( { verticalStack.addArrangedSubview($0) } )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            historyButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 46),
            historyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            logoImage.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 114),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 300),
            logoImage.heightAnchor.constraint(equalToConstant: 67.67),
            
            backgroundView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            verticalStack.topAnchor.constraint(equalTo: backgroundView.topAnchor,constant: 32),
            verticalStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            verticalStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            verticalStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -32),
            
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            loader.heightAnchor.constraint(equalToConstant: 72),
            loader.widthAnchor.constraint(equalTo: loader.heightAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
        ])
    }
}

// MARK: - Actions
private extension MainView {
    func addTarger() {
        startQuizButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        onStartQuizTapped?()
    }
    
    @objc func historyButtonTapped() {
        onHistoryTapped?()
    }
}

// MARK: - Public functions
extension MainView {
    func configureView(with title: String,
                       and message: String) {
        titleLabel.text = title
        errorLabel.text = message
    }
    
    func errorHidden(_ status: Bool) {
        errorLabel.isHidden = status
    }
    
    // Скрытие или показ лоудера совместно с частью интерфейса в зависимости от состояния экрана
    func showLoader(_ status: Bool) {
        loader.isHidden = !status
        if status {
            loader.startAnimating()
        } else {
            loader.stopAnimating()
        }
        
        [historyButton,
         backgroundView].forEach { $0.isHidden = status }
    }

}

