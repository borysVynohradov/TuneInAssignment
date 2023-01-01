//
//  APIRequest.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 26.12.2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APIRequest {
    var URL: URL { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    
    var queryItems: [URLQueryItem]? { get }
}

extension APIRequest {
    var method: HTTPMethod { .get }
    
    var headers: [String: String]? { nil }
    
    var queryItems: [URLQueryItem]? { [URLQueryItem(name: "render", value: "json")] }
}
