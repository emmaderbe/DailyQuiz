import UIKit

final class HistoryView: UIView {
    // MARK: - UI components
    private let titleLabel = LabelFactory.createLabel(with: .black, and: 32)
    private let historyEmptyView = HistoryEmptyView()
    private let logoImage = ImageFactory.createLogoImage()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Public callback
    var onStartTapped: (() -> Void)?
    var onBackTapped: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        startTapped()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension HistoryView {
    func setupView() {
        backgroundColor = AppColors.primaryPurple
        titleLabel.textColor = AppColors.white
        
        [titleLabel,
         collectionView,
         historyEmptyView,
         logoImage,
         ].forEach { addSubview($0) }
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            historyEmptyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            historyEmptyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            historyEmptyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            historyEmptyView.bottomAnchor.constraint(equalTo: logoImage.topAnchor, constant: -338),
            
            logoImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -76),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 40),
            logoImage.widthAnchor.constraint(equalToConstant: 180),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor ,constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -41)
        ])
    }
    
    func startTapped() {
        historyEmptyView.onStartTapped = { [weak self] in
            self?.onStartTapped?()
        }
    }
    
    @objc func backTapped() {
        onBackTapped?()
    }
}

// MARK: - Setup collectionView
private extension HistoryView {
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(104)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 24
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 26, bottom: 0, trailing: 26)
            
            return section
        }
        
        return layout
    }
}

//MARK: - Public set dataSource and delegate
extension HistoryView {
    func setDataSource(_ dataSource: HistoryDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - Public functions
extension HistoryView {
    func setupText(with title: String, and message: String) {
        titleLabel.text = title
        historyEmptyView.setupMessage(with: message)
    }
    
    func setEmptyViewHidden(_ isEmpty: Bool) {
        historyEmptyView.isHidden = !isEmpty
        logoImage.isHidden = !isEmpty

        collectionView.isHidden = isEmpty
        collectionView.isUserInteractionEnabled = !isEmpty
    }
}

