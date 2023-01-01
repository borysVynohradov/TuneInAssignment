//
//  APIProvider.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 26.12.2022.
//

import Foundation


protocol APIProvider {
    func executeRequest<T: Decodable>(_ request: APIRequest, completion: @escaping (Result<APIResponse<T>, Error>) -> Void)
}


