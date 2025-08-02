import UIKit

final class ResultsView: UIView {
    // MARK: - UI Components
    private let titleLabel = LabelFactory.createLabel(with: .black, and: 32)
    private let backgroundView = BackgroundViewFactory.createBackView()
    private let resultStack = StackFactory.createVerticalStack(with: 24)
    private let starImages = StarRatingView(starSize: CGSize(width: 52, height: 52))
    private let scoreLabel = LabelFactory.createLabel(with: .bold, and: 16)
    private let textStack = StackFactory.createVerticalStack(with: 14)
    private let titleResultLabel  = LabelFactory.createLabel(with: .bold, and: 24)
    private let descriptionResultLabel  = LabelFactory.createLabel(with: .regular, and: 16)
    private let restartButton = CustomButton(title: "Начать заново")
    
    // MARK: - Public Callback
    var onRestartTapped: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        addTarget()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension ResultsView {
    func setupUI() {
        backgroundColor = AppColors.primaryPurple
        titleLabel.textColor = AppColors.white
        scoreLabel.textColor = AppColors.yellow
        
        [titleLabel,
         backgroundView].forEach({ addSubview($0)} )
        
        backgroundView.addSubview(resultStack)
        
        [starImages,
         scoreLabel,
         textStack,
         restartButton].forEach( {resultStack.addArrangedSubview($0)} )
        resultStack.setCustomSpacing(64, after: textStack)
        
        [titleResultLabel,
         descriptionResultLabel].forEach( {textStack.addArrangedSubview($0)} )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
            
            resultStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 32),
            resultStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            resultStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            resultStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -32),
        ])
    }
}

// MARK: - Actions
private extension ResultsView {
    func addTarget() {
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
    }
    
    @objc func restartTapped() {
        onRestartTapped?()
    }
}

// MARK: - Public functions
extension ResultsView {
    func configure(resultTitle: String,
                   resultDescription: String,
                   scoreText: String,
                   stars: Int) {
        titleLabel.text = "Результаты"
        titleResultLabel.text = resultTitle
        descriptionResultLabel.text = resultDescription
        scoreLabel.text = scoreText
        starImages.setRating(stars)
    }
}

