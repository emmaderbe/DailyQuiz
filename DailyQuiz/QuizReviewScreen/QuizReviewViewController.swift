import UIKit

final class QuizReviewViewController: UIViewController {
    // MARK: - Private properties
    private let quizReviewView = QuizReviewView()

    // MARK: - Lifecycle
    override func loadView() {
        view = quizReviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupCallbacks()
    }
}

// MARK: - Private Setup
private extension QuizReviewViewController {
    
    func configureView() {
        // Пример конфигурации результата
        quizReviewView.configure(
            resultTitle: "Отличный результат!",
            resultDescription: "Ты хорошо справился с заданием.",
            scoreText: "4 из 5",
            stars: 4
        )
        
        // Пример моковых карточек
        let mockCards: [QuizReviewCardModel] = [
            .init(
                question: "Что делает ключевое слово `lazy` в Swift?",
                answers: ["Создаёт объект сразу", "Создаёт объект при первом обращении", "Удаляет объект", "Ограничивает доступ"],
                correctIndex: 1,
                selectedIndex: 1,
            ),
            .init(
                question: "Что означает SOLID?",
                answers: ["Набор архитектурных принципов", "Фреймворк", "Тип данных", "Структура проекта"],
                correctIndex: 0,
                selectedIndex: 2,
            ),
            .init(
                question: "Что такое MVVM?",
                answers: ["Дизайн UI", "Архитектура", "Фреймворк", "Библиотека"],
                correctIndex: 1,
                selectedIndex: 1,
            )
        ]
        
        quizReviewView.setCards(mockCards)
    }
    
    func setupCallbacks() {
        quizReviewView.onRestartTapped = { [weak self] in
            print("Начать заново")
        }
    }
}
