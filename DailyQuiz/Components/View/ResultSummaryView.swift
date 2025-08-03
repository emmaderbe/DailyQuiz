import UIKit

final class ResultSummaryView: UIView {
    // MARK: - UI components
    private let backgroundView = BackgroundViewFactory.createBackView()
    private let resultStack = StackFactory.createVerticalStack(with: 24)
    private let starImages: StarRatingView
    private let scoreLabel = LabelFactory.createLabel(with: .bold,
                                                      and: 16)
    private let titleResultLabel  = LabelFactory.createLabel(with: .bold,
                                                             and: 24)
    private let descriptionResultLabel  = LabelFactory.createLabel(with: .regular,
                                                                   and: 16)
    private let textStack = StackFactory.createVerticalStack(with: 14)
    private let restartButton = CustomButton(title: "Начать заново")
    
    // MARK: - Private propetries
    private var showButton: Bool
    
    // MARK: - Public callback
    var onStartTapped: (() -> Void)?
    
    // MARK: - Init
    init(starSize: CGSize,
         showButton: Bool = false) {
        self.starImages = StarRatingView(starSize: starSize)
        self.showButton = showButton
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        addTarget()
        hideButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension ResultSummaryView {
    func setupUI() {
        self.scoreLabel.textColor = AppColors.yellow
        
        [backgroundView].forEach({ addSubview($0)} )
        
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
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            resultStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 32),
            resultStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            resultStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            resultStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -32),
        ])
    }
    
    func hideButton() {
        restartButton.isHidden = !showButton
    }
}

// MARK: - Action
private extension ResultSummaryView {
    func addTarget() {
        restartButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }
    
    @objc func startTapped() {
        onStartTapped?()
    }
}

// MARK: - Public function
extension ResultSummaryView {
    func configure(stars: Int,
                   score: String,
                   title: String,
                   description: String) {
        starImages.setRating(stars)
        scoreLabel.text = score
        titleResultLabel.text = title
        descriptionResultLabel.text = description
    }
}
