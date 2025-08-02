import UIKit

final class ResultCardView: UIView {
    // MARK: - UI Components
    private let backgroundView = BackgroundViewFactory.createBackView()
    private let progressLabel = LabelFactory.createLabel(with: .bold, and: 16)
    private let resultIcon = ImageFactory.createIcon(with: .incorrect)
    private let questionLabel = LabelFactory.createLabel(with: .bold, and: 18)
    private let backVerticalStack = StackFactory.createVerticalStack(with: 24)
    private let backHorizontalStack = StackFactory.createHorizontalStack(with: 24)
    private let answersStack = StackFactory.createVerticalStack(with: 16)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ResultCardView {
    func setupUI() {
        backgroundColor = .clear
        addSubview(backgroundView)
        
        backgroundView.addSubview(backVerticalStack)
        
        [backHorizontalStack,
         questionLabel,
         answersStack].forEach {
            backVerticalStack.addArrangedSubview($0)
        }
        
        [progressLabel,
         resultIcon].forEach( { backHorizontalStack.addArrangedSubview($0)} )
        
        progressLabel.textColor = AppColors.gray
        backHorizontalStack.alignment = .center
        backHorizontalStack.distribution = .equalSpacing
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backVerticalStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 38),
            backVerticalStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 30),
            backVerticalStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30),
            backVerticalStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -38)
        ])
    }
}

// MARK: - Public Configuration
extension ResultCardView {
    func configure(
        progressText: String,
        resultIcon: ResultIcon,
        questionText: String,
        answers: [String],
        correctIndex: Int,
        selectedIndex: Int?,
        isCorrect: Bool) {
            self.questionLabel.text = questionText
            self.progressLabel.text = progressText
            self.resultIcon.image = UIImage(named: resultIcon.rawValue)
            self.answersStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            for (index, text) in answers.enumerated() {
                let button = AnswerButton(title: text)
                button.isUserInteractionEnabled = false
                if index == selectedIndex {
                    button.applyState(isCorrect ? .correct : .incorrect)
                } else {
                    button.applyState(.defaultChoice)
                }
                answersStack.addArrangedSubview(button)
            }
        }
}
