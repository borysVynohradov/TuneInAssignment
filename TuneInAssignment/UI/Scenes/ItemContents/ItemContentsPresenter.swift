//
//  ItemContentsPresenter.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 01.01.2023.
//

import AVKit
import Foundation

protocol ItemContentsPresenterInput {
    func fetchContents()
    func updateURL(_ URL: URL)
    func openItem(_ item: DirectoryItemTableViewCellModel)
}

protocol ItemContentsPresenterOutput: AnyObject {
    func updateActivityIndicator(isActive: Bool)
    func displayItems(_ items: [String: [DirectoryItemTableViewCellModel]])
}

@MainActor class ItemContentsPresenter {
    
    // Dependencies
    private var URL: URL?
    private let repository: DirectoryContentsRepositoryInput
    private weak var coordinator: MainCoordinatorInput?
    private weak var output: ItemContentsPresenterOutput?
    
    // Data
    private var categoryContents = [DirectoryItem]()
    
    init(
        URL: URL?,
        repository: DirectoryContentsRepositoryInput,
        coordinator: MainCoordinatorInput,
        output: ItemContentsPresenterOutput?
    ) {
        self.URL = URL
        self.repository = repository
        self.coordinator = coordinator
        self.output = output
    }
}

// MARK: - Input
extension ItemContentsPresenter: ItemContentsPresenterInput {
    func fetchContents() {
        guard let URL else { return }
        
        output?.updateActivityIndicator(isActive: true)
        
        Task {
            do {
                categoryContents = try await repository.getContents(URL: URL)
                output?.updateActivityIndicator(isActive: false)
                processCategoryContents()
            } catch {
                // Error handling
                print(error)
            }
        }
    }
    
    func updateURL(_ URL: URL) {
        self.URL = URL
        fetchContents()
    }
    
    func openItem(_ item: DirectoryItemTableViewCellModel) {
        switch item.type {
        case .audio:
            playAudio(url: item.URL)
        default:
            showContents(url: item.URL)
        }
    }
    
    func playAudio(url: URL?) {
        guard let url else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            let player = AVPlayer(url: url)

            coordinator?.playAudio(player: player)
        } catch {
            // Error handling
            print(error)
        }
    }
    
    func showContents(url: URL?) {
        guard let url else { return }
        
        coordinator?.showContents(for: url)
    }
}

// MARK: - Presentation
private extension ItemContentsPresenter {
    
    func processCategoryContents() {
        var sections = [String: [DirectoryItemTableViewCellModel]]()
        
        categoryContents.forEach { item in
            if let children = item.children, !children.isEmpty {
                sections[item.text] = children.map { DirectoryItemTableViewCellModel(directoryItem: $0) }
            } else {
                let model = DirectoryItemTableViewCellModel(directoryItem: item)
                sections["", default: []].append(model)
            }
        }
        
        output?.displayItems(sections)
    }
}
