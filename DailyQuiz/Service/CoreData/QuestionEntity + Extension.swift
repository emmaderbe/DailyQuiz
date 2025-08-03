import Foundation

extension QuestionEntity {
    static func decodeAnswers(_ string: String?) -> [String] {
        guard let string = string,
              let data = string.data(using: .utf8) else { return [] }
        do {
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("Decode error:", error)
            return []
        }
    }
}

extension QuestionEntity {
    static func encodeAnswers(_ answers: [String]) -> String? {
        guard let data = try? JSONEncoder().encode(answers) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

