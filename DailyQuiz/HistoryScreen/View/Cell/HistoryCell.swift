import UIKit

final class HistoryCell: UICollectionViewCell {
    // MARK: - UI Components
    private let titleLabel = LabelFactory.createLabel(with: .bold,
                                                      and: 24)
    private let dateLabel = LabelFactory.createLabel(with: .regular,
                                                     and: 12)
    private let timeLabel = LabelFactory.createLabel(with: .regular,
                                                     and: 12)
    private let starRatingView = StarRatingView(starSize: CGSize(width: 16,
                                                                 height: 16))
    private let firstVertStack = StackFactory.createVerticalStack(with: 12)
    private let secondtVertStack = StackFactory.createVerticalStack(with: 12)
    private let horizontalStack = StackFactory.createHorizontalStack(with: 12)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension HistoryCell {
    func setupView() {
        contentView.backgroundColor = AppColors.white
        titleLabel.textColor = AppColors.darkPurple
        contentView.layer.cornerRadius = 40
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(horizontalStack)
        editStacks()
        
        [firstVertStack,
         secondtVertStack].forEach( { horizontalStack.addArrangedSubview($0) } )
        
        [titleLabel,
         dateLabel].forEach { firstVertStack.addArrangedSubview($0) }
        
        [starRatingView,
         timeLabel].forEach( {secondtVertStack.addArrangedSubview($0)} )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }
    
    func editStacks() {
        horizontalStack.distribution = .equalSpacing
        horizontalStack.alignment = .center
        
        firstVertStack.alignment = .leading
        secondtVertStack.alignment = .trailing
    }
}

extension HistoryCell {
    func configure(with data: QuizResultModel) {
        titleLabel.text = data.title
        dateLabel.text = data.formateDate
        timeLabel.text = data.formateTime
        starRatingView.setRating(data.stars)
    }
}

//MARK: - Identifier of cell
extension HistoryCell {
    static var identifier: String {
        String(describing: HistoryCell.self)
    }
}
