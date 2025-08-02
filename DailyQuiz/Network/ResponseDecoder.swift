import Foundation

// MARK: - Protocol
protocol ResponseDecoderProtocol {
    func decode<T: Decodable>(_ type: T.Type,
                              from data: Data) -> Result<T, Error>
}

// MARK: - Response decoder
final class ResponseDecoder: ResponseDecoderProtocol {
    func decode<T: Decodable>(_ type: T.Type,
                              from data: Data) -> Result<T, Error> {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(NetworkError.decodingFailed)
        }
    }
}
