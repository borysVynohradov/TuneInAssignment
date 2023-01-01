//
//  DirectoryItemTableViewCellModel.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 30.12.2022.
//

import Foundation

struct DirectoryItemTableViewCellModel: Hashable {
    let title: String
    let subtitle: String?
    let imageURL: URL?
    let URL: URL?
    let type: DirectoryItemType?
    
    init(directoryItem: DirectoryItem) {
        self.title = directoryItem.text
        self.subtitle = directoryItem.currentTrack ?? directoryItem.subtext
        self.imageURL = directoryItem.image
        self.URL = directoryItem.URL
        self.type = directoryItem.type
    }
}
