import UIKit

enum StarType {
    case active
    case inactive
}

final class StarRatingView: UIView {
    // MARK: - Private Properties
    private let maxStars: Int
    private var stars: [UIImageView] = []
    private let stackView: UIStackView = StackFactory.createHorizontalStack(with: 8)
    
    // MARK: - Init
    init(count: Int = 5) {
        self.maxStars = count
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Method
extension StarRatingView {
    func setRating(_ activeCount: Int) {
        for (index, star) in stars.enumerated() {
            let type: StarType = index < activeCount ? .active : .inactive
            star.image = setImage(for: type)
        }
    }
}

// MARK: - UI setup
private extension StarRatingView {
    func setupView() {
        backgroundColor = .clear
        addSubview(stackView)
        
        createStars()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - Create star
private extension StarRatingView {
    func createStars() {
        for _ in 0..<maxStars {
            let imageView = makeStarImageView(type: .inactive)
            stars.append(imageView)
            stackView.addArrangedSubview(imageView)
        }
    }
    
    func makeStarImageView(type: StarType) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = setImage(for: type)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        return imageView
    }
    
    func setImage(for type: StarType) -> UIImage? {
        switch type {
        case .active:
            return UIImage(named: "starActive")
        case .inactive:
            return UIImage(named: "starInactive")
        }
    }
}


