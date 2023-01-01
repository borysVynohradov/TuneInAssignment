//
//  UIViewController+EmbedChild.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 02.01.2023.
//

import UIKit

extension UIViewController {
    func addChildViewController(_ viewController: UIViewController, to view: UIView) {
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
        
        NSLayoutConstraint.activate(
            [
                viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
        
        viewController.didMove(toParent: self)
    }
}
