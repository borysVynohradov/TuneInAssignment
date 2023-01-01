//
//  URLContentsRepository.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 29.12.2022.
//

import Foundation

protocol DirectoryContentsRepositoryInput {
    func getContents(URL: URL?) async throws -> [DirectoryItem]
}

class DirectoryContentsRepository: DirectoryContentsRepositoryInput {
    private enum Constants {
        static let rootDirectoryURL = URL(string: "https://opml.radiotime.com")!
    }
    
    private let provider: APIProvider
    
    init(provider: APIProvider) {
        self.provider = provider
    }
    
    func getContents(URL: URL?) async throws -> [DirectoryItem] {
        let request = GetURLContentsRequest(URL: URL ?? Constants.rootDirectoryURL)
        
        return try await withCheckedThrowingContinuation { continuation in
            var continuation: CheckedContinuation<[DirectoryItem], Error>? = continuation
            
            provider.executeRequest(request) { (result: Result<APIResponse<DirectoryItem>, Error>) in
                switch result {
                case .success(let response):
                    continuation?.resume(returning: response.body)
                    continuation = nil
                case .failure(let error):
                    continuation?.resume(throwing: error)
                    continuation = nil
                }
            }
        }
    }
}
