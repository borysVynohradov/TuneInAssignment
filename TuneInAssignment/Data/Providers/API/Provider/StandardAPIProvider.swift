//
//  StandardAPIProvider.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 26.12.2022.
//

import Foundation

enum APIRequestError: Error {
    case invalidURL
}

class StandardAPIProvider: APIProvider {
    private static let jsonDecoder = JSONDecoder()
    
    func executeRequest<T: Decodable>(
        _ request: APIRequest,
        completion: @escaping (Result<APIResponse<T>, Error>) -> Void
    ) {
        guard var components = URLComponents(string: request.URL.absoluteString) else {
            completion(.failure(APIRequestError.invalidURL))
            return
        }
        
        components.queryItems = (components.queryItems ?? []) + (request.queryItems ?? [])
        
        guard let url = components.url else {
            completion(.failure(APIRequestError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error {
                completion(.failure(error))
            }
            
            do {
                let result = try Self.jsonDecoder.decode(APIResponse<T>.self, from: data ?? Data())
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
