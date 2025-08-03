import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case serverError
    case unknown
}

// MARK: - Network service
protocol QuizNetworkServiceProtocol {
    func fetchQuiz(category: String?,
                   difficulty: String?,
                   completion: @escaping (Result<QuizResponse, Error>) -> Void)
}


final class QuizNetworkService: QuizNetworkServiceProtocol {
    private let session: URLSession
    private let decoder: ResponseDecoderProtocol
    private let urlBuilder: URLBuilderProtocol
    
    init(session: URLSession = .shared,
         decoder: ResponseDecoderProtocol = ResponseDecoder(),
         urlBuilder: URLBuilderProtocol = URLBuilder()) {
        self.session = session
        self.decoder = decoder
        self.urlBuilder = urlBuilder
    }
    
    func fetchQuiz(category: String?,
                   difficulty: String?,
                   completion: @escaping (Result<QuizResponse, Error>) -> Void) {
        guard let url = urlBuilder.buildQuizURL(category: category,
                                                difficulty: difficulty) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            
            let result: Result<QuizResponse, Error> = self.decoder.decode(QuizResponse.self, from: data)
            completion(result)
        }.resume()
    }
}
