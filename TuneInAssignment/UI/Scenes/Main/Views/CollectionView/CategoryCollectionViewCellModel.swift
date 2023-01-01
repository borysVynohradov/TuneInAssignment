//
//  CategoryCollectionViewCellModel.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 30.12.2022.
//

import Foundation

struct CategoryCollectionViewCellModel: Hashable {
    let name: String
    
    init(directoryItem: DirectoryItem) {
        self.name = directoryItem.text
    }
}
