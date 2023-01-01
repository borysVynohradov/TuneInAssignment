//
//  FlowCoordinator.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 30.12.2022.
//

import AVKit
import UIKit

@MainActor protocol MainCoordinatorInput: AnyObject {
    func playAudio(player: AVPlayer)
    func showContents(for url: URL, in containerView: UIView)
    func showContents(for url: URL)
}

@MainActor class MainCoordinator {
    private enum Constants {
        static let storyboard = "Main"
    }
    
    private let dependencyContainer: DependencyContainer
    private unowned var navigationController: UINavigationController!
    private unowned var mainViewController: MainViewController!
    
    init(window: UIWindow, dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
        navigationController = window.rootViewController as? UINavigationController
        mainViewController = prepareMainScene()
        
        navigationController.viewControllers = [mainViewController]
        window.makeKeyAndVisible()
    }
}

// MARK: - Navigation
extension MainCoordinator: MainCoordinatorInput {

    func playAudio(player: AVPlayer) {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        navigationController?.present(controller, animated: true)

        player.play()
    }
    
    func showContents(for URL: URL, in containerView: UIView) {
        if let childViewController = mainViewController.children.first as? ItemContentsViewController {
            childViewController.presenter.updateURL(URL)
        } else {
            let controller = prepareItemContentsScene(for: URL)
            mainViewController.addChildViewController(controller, to: containerView)
        }
    }
    
    func showContents(for URL: URL) {
        let controller = prepareItemContentsScene(for: URL)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - Scene initialisation
private extension MainCoordinator {
    func prepareMainScene() -> MainViewController {
        return UIStoryboard(name: Constants.storyboard, bundle: nil).instantiateViewController { controller in
            let presenter = MainPresenter(
                repository: self.dependencyContainer.repositories.directoryContents,
                coordinator: self,
                output: controller
            )
            controller.presenter = presenter
        }
    }
    
    func prepareItemContentsScene(for URL: URL) -> ItemContentsViewController {
        return UIStoryboard(name: Constants.storyboard, bundle: nil).instantiateViewController { controller in
            let presenter = ItemContentsPresenter(
                URL: URL,
                repository: self.dependencyContainer.repositories.directoryContents,
                coordinator: self,
                output: controller
            )
            controller.presenter = presenter
        }
    }
}
