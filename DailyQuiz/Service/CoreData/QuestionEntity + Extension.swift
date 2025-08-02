import Foundation

extension QuestionEntity {
    var decodedAnswers: [String] {
        guard let jsonString = answers,
              let data = jsonString.data(using: .utf8),
              let decoded = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        return decoded
    }
}

extension QuestionEntity {
    static func encodeAnswers(_ answers: [String]) -> String? {
        guard let data = try? JSONEncoder().encode(answers) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

