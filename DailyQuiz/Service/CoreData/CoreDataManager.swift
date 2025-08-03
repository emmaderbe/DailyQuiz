import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func saveQuizSession(id: Int, date: Date, correctAnswers: Int, questions: [QuestionModel], selectedAnswers: [Int])
    func fetchQuizSessions() -> [QuizSessionEntity]
    func deleteSessionById(_ id: Int)
    func nextQuizId() -> Int
}

extension Notification.Name {
    static let dataDidChange = Notification.Name("dataDidChange")
}

final class CoreDataManager: CoreDataManagerProtocol {
    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

extension CoreDataManager {
    func saveQuizSession(id: Int,
                         date: Date,
                         correctAnswers: Int,
                         questions: [QuestionModel],
                         selectedAnswers: [Int]) {
        let session = QuizSessionEntity(context: context)
        session.id = Int16(id)
        session.date = date
        session.correctAnswers = Int16(correctAnswers)
        
        for (index, question) in questions.enumerated() {
            let questionEntity = QuestionEntity(context: context)
            questionEntity.questionText = question.text
            questionEntity.answers = QuestionEntity.encodeAnswers(question.answers)
            questionEntity.correctAnswerIndex = Int16(question.correctAnswerIndex)
            questionEntity.selectedAnswerIndex = Int16(selectedAnswers[index])
            questionEntity.isCorrect = question.correctAnswerIndex == selectedAnswers[index]
            questionEntity.quizSession = session
        }
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .dataDidChange, object: nil)
        } catch {
            print("Failed to save session: \(error)")
        }
    }
    
    func deleteSessionById(_ id: Int) {
        let request: NSFetchRequest<QuizSessionEntity> = QuizSessionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        if let result = try? context.fetch(request), let session = result.first {
            deleteSession(session)
        }
    }
    
    private func deleteSession(_ session: QuizSessionEntity) {
        context.delete(session)
        do {
            try context.save()
            NotificationCenter.default.post(name: .dataDidChange, object: nil)
        } catch {
            print("Failed to delete session: \(error)")
        }
    }
}

extension CoreDataManager {
    func nextQuizId() -> Int {
        let request: NSFetchRequest<QuizSessionEntity> = QuizSessionEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        
        do {
            if let last = try context.fetch(request).first {
                return Int(last.id) + 1
            }
        } catch {
            print("Failed to fetch last quiz id: \(error)")
        }
        return 1
    }
    
    func fetchQuizSessions() -> [QuizSessionEntity] {
        let request: NSFetchRequest<QuizSessionEntity> = QuizSessionEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch sessions: \(error)")
            return []
        }
    }
}

