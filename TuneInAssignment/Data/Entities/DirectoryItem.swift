//
//  DirectoryItem.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 24.12.2022.
//

import Foundation

struct DirectoryItem: Codable {
    let type: DirectoryItemType?
    let URL: URL?
    let text: String
    let subtext: String?
    let currentTrack: String?
    let image: URL?
    let children: [DirectoryItem]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case URL
        case text
        case subtext
        case currentTrack = "current_track"
        case image
        case children
    }
    
}
