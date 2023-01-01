//
//  Dependencies.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 02.01.2023.
//

import Foundation

// Simple dependency container (could be replaced with DI in a real project)
struct DependencyContainer {
    let repositories: Repositories
}

extension DependencyContainer {
    struct Repositories {
        let directoryContents: DirectoryContentsRepositoryInput
    }
}
