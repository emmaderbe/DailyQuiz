import UIKit

final class QuizReviewView: UIView {
    // MARK: - UI Components
    private let scrollView: UIScrollView  = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let resultLabel = LabelFactory.createLabel(with: .black,
                                                       and: 32)
    private let resultSummaryView = ResultSummaryView(starSize: CGSize(width: 52,
                                                                       height: 52))
    private let answerTitle = LabelFactory.createLabel(with: .black,
                                                       and: 32)
    private let answerStack = StackFactory.createVerticalStack(with: 24)
    private let restartButton = CustomButton(title: "Начать заново",
                                             style: .white)
    
    // MARK: - Public сallbacks
    var onRestartTapped: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension QuizReviewView {
    func setupView() {
        backgroundColor = AppColors.primaryPurple
        resultLabel.textColor = AppColors.white
        answerTitle.textColor = AppColors.white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [ resultLabel,
          resultSummaryView,
          answerTitle,
          answerStack,
          restartButton ].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            resultLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            resultLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            resultSummaryView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 40),
            resultSummaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            resultSummaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),

            answerTitle.topAnchor.constraint(equalTo: resultSummaryView.bottomAnchor, constant: 36),
            answerTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            answerStack.topAnchor.constraint(equalTo: answerTitle.bottomAnchor, constant: 24),
            answerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            answerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),

            restartButton.topAnchor.constraint(equalTo: answerStack.bottomAnchor, constant: 24),
            restartButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            restartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
}

// MARK: - Actions
private extension QuizReviewView {
    func addTarget() {
        restartButton.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
    }
    
    @objc func restartTapped() {
        onRestartTapped?()
    }
}

// MARK: - Public functions
extension QuizReviewView {
    func configure(resultTitle: String,
                   resultDescription: String,
                   scoreText: String,
                   stars: Int) {
        resultLabel.text = "Результаты"
        answerTitle.text = "Твои ответы"
        resultSummaryView.configure(stars: stars,
                                    score: scoreText,
                                    title: resultTitle,
                                    description: resultDescription)
    }
}

extension QuizReviewView {
    func setCards(_ cards: [QuizReviewCardModel]) {
        // Удаляем предыдущие карточки
        answerStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Добавляем новые карточки
        for (index, card) in cards.enumerated() {
            let cardView = ResultCardView()
            cardView.configure(
                progressText: "Вопрос \(index + 1) из \(cards.count)",
                resultIcon: card.isCorrect ? .correct : .incorrect,
                questionText: card.question,
                answers: card.answers,
                correctIndex: card.correctIndex,
                selectedIndex: card.selectedIndex,
                isCorrect: card.isCorrect
            )
            answerStack.addArrangedSubview(cardView)
        }
    }
}


