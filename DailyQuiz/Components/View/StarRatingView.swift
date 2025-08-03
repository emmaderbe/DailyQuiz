import UIKit

// MARK: - StarType
enum StarType {
    case active
    case inactive
}

final class StarRatingView: UIView {
    // MARK: - Private properties
    private let maxStars: Int
    private let starSize: CGSize
    // MARK: - UI components
    private var stars: [UIImageView] = []
    private let stackView: UIStackView = StackFactory.createHorizontalStack(with: 8)
    
    // MARK: - Init
    init(count: Int = 5, starSize: CGSize) {
        self.maxStars = count
        self.starSize = starSize
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI setup
private extension StarRatingView {
    func setupView() {
        self.backgroundColor = .clear
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
    // Создание массива неактивных звёзд и добавление их в стек
    func createStars() {
        for _ in 0..<maxStars {
            let imageView = makeStarImageView(type: .inactive)
            stars.append(imageView)
            stackView.addArrangedSubview(imageView)
        }
    }
    
    // Создание UIImageView для звезды с заданным типом
    func makeStarImageView(type: StarType) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = setImage(for: type)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        return imageView
    }
    
    // Изменение  изображения в зависимости от типа звезды
    func setImage(for type: StarType) -> UIImage? {
        switch type {
        case .active:
            return UIImage(named: "starActive")
        case .inactive:
            return UIImage(named: "starInactive")
        }
    }
}

// MARK: - Public Method
extension StarRatingView {
    // Изменения соотношения активных и неактивных звёзд в зависимости от полученного рейтинга
    func setRating(_ activeCount: Int) {
        for (index, star) in stars.enumerated() {
            let type: StarType = index < activeCount ? .active : .inactive
            star.image = setImage(for: type)
        }
    }
}



