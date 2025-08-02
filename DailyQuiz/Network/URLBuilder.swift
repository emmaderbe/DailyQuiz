import Foundation

// MARK: - Protocol
protocol URLBuilderProtocol {
    func buildQuizURL(category: String?, difficulty: String?) -> URL?
}

// MARK: - URLBuilder
final class URLBuilder: URLBuilderProtocol {
    func buildQuizURL(category: String?, difficulty: String?) -> URL? {
        var components = URLComponents(string: "https://opentdb.com/api.php")
        var queryItems: [URLQueryItem] = [
            .init(name: "amount", value: "5"),
            .init(name: "type", value: "multiple")
        ]
        
        if let category = category {
            queryItems.append(.init(name: "category", value: category))
        }
        if let difficulty = difficulty {
            queryItems.append(.init(name: "difficulty", value: difficulty))
        }

        components?.queryItems = queryItems
        return components?.url
    }
}
