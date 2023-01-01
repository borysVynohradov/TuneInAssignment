//
//  MainPresenter.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 29.12.2022.
//

import UIKit

protocol MainPresenterInput {
    func fetchContents()
    func selectItem(at indexPath: IndexPath)
}

protocol MainPresenterOutput: AnyObject {
    var container: UIView { get }
    
    func selectDefaultItem(at index: Int)
    func displayItems(_ items: [CategoryCollectionViewCellModel])
}

@MainActor class MainPresenter {
    
    // Dependencies
    private let repository: DirectoryContentsRepositoryInput
    private weak var coordinator: MainCoordinatorInput?
    private weak var output: MainPresenterOutput?
    
    // Data
    private var items = [DirectoryItem]()
    
    init(
        repository: DirectoryContentsRepositoryInput,
        coordinator: MainCoordinatorInput,
        output: MainPresenterOutput?
    ) {
        self.repository = repository
        self.coordinator = coordinator
        self.output = output
        
    }
}

// MARK: - Input
extension MainPresenter: MainPresenterInput {
    func fetchContents() {
        Task {
            do {
                items = try await repository.getContents(URL: nil)
                processItems()
            } catch {
                // Error handling
                print(error)
            }
        }
    }
    
    func selectItem(at indexPath: IndexPath) {
        guard let URL = items[indexPath.item].URL, let container = output?.container else {
            return
        }
        coordinator?.showContents(for: URL, in: container)
    }
}

// MARK: - Presentation
private extension MainPresenter {
    func processItems() {
        let models = items.map { CategoryCollectionViewCellModel(directoryItem: $0) }
        output?.displayItems(models)
        
        if !items.isEmpty {
            self.output?.selectDefaultItem(at: 0)
        }
    }
}
