//
//  GetURLContentsRequest.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 26.12.2022.
//

import Foundation

struct GetURLContentsRequest: APIRequest {
    let URL: URL
    
    var method: HTTPMethod { .get }
}
