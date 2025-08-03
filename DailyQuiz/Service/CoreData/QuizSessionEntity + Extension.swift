import CoreData

extension QuizSessionEntity {
    var questionsArray: [QuestionEntity] {
        let set = questions as? Set<QuestionEntity> ?? []
        return set.sorted { ($0.questionText ?? "") < ($1.questionText ?? "") }
    }
}

extension QuestionEntity {
    static func decodeAnswers(_ data: Data?) -> [String] {
        guard let data else { return [] }
        do {
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("Failed to decode answers: \(error)")
            return []
        }
    }
}
