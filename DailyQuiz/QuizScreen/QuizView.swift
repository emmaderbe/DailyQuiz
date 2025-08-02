import UIKit

final class QuizView: UIView {
    // MARK: - UI сomponents
    private let logoImage = ImageFactory.createLogoImage()
    private let backroundView = BackgroundViewFactory.createBackView()
    private let progressLabel = LabelFactory.createLabel(with: .bold, and: 16)
    private let questionLabel = LabelFactory.createLabel(with: .semibold, and: 18)
    private let backStack = StackFactory.createVerticalStack(with: 24)
    private let answersStack = StackFactory.createVerticalStack(with: 16)
    private let nextButton = CustomButton(title: "Далее", style: .disabled)
    private let warningLabel = LabelFactory.createLabel(with: .regular, and: 10)
    
    // MARK: - Public сallbacks
    var onAnswerSelected: ((Int) -> Void)?
    var onNextTapped: (() -> Void)?
    
    // MARK: - Private properties
    private var answerButtons: [AnswerButton] = []
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.primaryPurple
        setupUI()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension QuizView {
    func setupUI() {
        self.backgroundColor = AppColors.primaryPurple
        progressLabel.textColor = AppColors.secondaryPurple
        warningLabel.textColor = AppColors.white
        warningLabel.text = "Вернуться к предыдущим вопросам нельзя"
        
        [logoImage,
         backroundView,
         warningLabel].forEach { addSubview($0) }
        
        backroundView.addSubview(backStack)
        
        [progressLabel,
         questionLabel,
         answersStack, nextButton].forEach( {backStack.addArrangedSubview($0)} )
        
        backStack.setCustomSpacing(67, after: answersStack)
        
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(greaterThanOrEqualToConstant: 180),
            logoImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            backroundView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            backroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            backroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            
            backStack.topAnchor.constraint(equalTo: backroundView.topAnchor, constant: 32),
            backStack.leadingAnchor.constraint(equalTo: backroundView.leadingAnchor, constant: 24),
            backStack.trailingAnchor.constraint(equalTo: backroundView.trailingAnchor, constant: -24),
            backStack.bottomAnchor.constraint(equalTo: backroundView.bottomAnchor, constant: -32),
            
            warningLabel.topAnchor.constraint(equalTo: backroundView.bottomAnchor, constant: 16),
            warningLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

// MARK: - Public functions
extension QuizView {
    func setQuestion(question: String, progress: String) {
        questionLabel.text = question
        progressLabel.text = progress
    }
    
    // Создание кнопок с вариантами ответа
    func setAnswers(_ answers: [String]) {
        clearAnswers()
        
        for (index, answer) in answers.enumerated() {
            let button = AnswerButton(title: answer)
            button.tag = index
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            answersStack.addArrangedSubview(button)
            answerButtons.append(button)
        }
        
        nextButton.applyStyle(.disabled)
    }
    
    // Применение нового состония к кнопке с выбранным индексом
    func updateAnswerState(at index: Int, to state: QuizAnswerState) {
        guard index >= 0, index < answerButtons.count else { return }
        answerButtons[index].applyState(state)
    }
    
    // Сбрасывание состояния всех кнопок ответа до указанного (по умолчанию — defaultChoice)
    func resetAnswerStates(to state: QuizAnswerState = .defaultChoice) {
        for button in answerButtons {
            button.applyState(state)
        }
    }
}

// MARK: - UI Setup
private extension QuizView {
    // Удаление всех кнопок с вариантами ответов
    func clearAnswers() {
        answerButtons.forEach { $0.removeFromSuperview() }
        answerButtons.removeAll()
    }
    
    // Активация кнопки "Далее"
    func enableNextButton() {
        nextButton.applyStyle(.active)
        
    }
    
    // Изменение UI кнопки с ответом при ее нажатии
    func updateButton(at index: Int) {
        for (i, button) in answerButtons.enumerated() {
            button.applyState(i == index ? .selected : .defaultChoice)
        }
        enableNextButton()
    }
    
}

// MARK: - Actions
private extension QuizView {
    // Обработка выбора ответа при нажатии на кнопку
    @objc func answerTapped(_ sender: UIButton) {
        let selectedIndex = sender.tag
        updateButton(at: selectedIndex)
        onAnswerSelected?(selectedIndex)
    }
    
    // Обработка нажатия на кнопку "Далее"
    @objc func nextTapped() {
        onNextTapped?()
    }
}

