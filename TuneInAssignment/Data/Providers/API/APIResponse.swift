//
//  APIResponse.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 26.12.2022.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    struct Head: Codable {
        let title: String
        let status: String
        let fault: String?
    }
    
    let head: Head
    let body: [T]
}
