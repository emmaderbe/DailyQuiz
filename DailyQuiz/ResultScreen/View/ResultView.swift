import UIKit

final class ResultsView: UIView {
    // MARK: - UI Components
    private let titleLabel = LabelFactory.createLabel(with: .black,
                                                      and: 32)
    private let resultSummaryView = ResultSummaryView(starSize: CGSize(width: 52,
                                                                       height: 52),
                                                      showButton: true)
    
    var onRestartTapped: (() -> Void)?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        addTarget()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension ResultsView {
    func setupView() {
        self.backgroundColor = AppColors.primaryPurple
        titleLabel.textColor = AppColors.white
        
        [titleLabel,
         resultSummaryView].forEach({ addSubview($0)} )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            resultSummaryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            resultSummaryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27),
            resultSummaryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
            
        ])
    }
    
    func addTarget() {
        resultSummaryView.onStartTapped = { [weak self] in
            self?.onRestartTapped?()
        }
    }
}

// MARK: - Public functions
extension ResultsView {
    func configure(resultTitle: String,
                   resultDescription: String,
                   scoreText: String,
                   stars: Int) {
        titleLabel.text = "Результаты"
        resultSummaryView.configure(stars: stars,
                                    score: scoreText,
                                    title: resultTitle,
                                    description: resultDescription)
    }
}

